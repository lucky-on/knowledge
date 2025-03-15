import argparse # to parse arguments
import boto3    # to transfer data to/from S3
import re
import os       # to remove temporary file
import heapq    # for max heap data structure, if that would not exist I would develop my own max heap
from botocore.exceptions import NoCredentialsError

"""
Complexity
1. Run time: Insertion and invoking element from max_heap is O(Log(N)) time,
   means overall complexity O(NLog(N)) because we still need to insert all keys
   from the file at least once.
2. Memory: O(K_MAX) since we store only K_MAX elements in the heap, so we should
   be able to process very big files or conctant stream of data
"""

# register and parse argument this script can accept
parser = argparse.ArgumentParser(description='Process S3 arguments')
parser.add_argument('--bucket', type=str, help='S3 Bucket Name')
parser.add_argument('--file', type=str , help='S3 File Name')
parser.add_argument('--access_key', type=str, help='S3 Access Key')
parser.add_argument('--secret_key', type=str, help='S3 Secret Key')
parser.add_argument('-k', '--k_max', type=int, default=500, help='Number of max elements to filter out')

args = parser.parse_args()

# store them into a separate variable for convenience
ACCESS_KEY = args.access_key
SECRET_KEY = args.secret_key
BUCKET = args.bucket
FILE = args.file
K_MAX = args.k_max

# Function to download arbitrary file from arbitrary s3 bucket
def download_file_from_s3(s3_file, bucket, access_key, secret_key):
    s3 = boto3.client('s3', aws_access_key_id=access_key, aws_secret_access_key=secret_key)
    try:
        s3.download_file(bucket, s3_file, s3_file)
        print("Successfully downloaded file '" + s3_file + "' from the bucket '"
                + bucket + "'")
        return True
    except FileNotFoundError:
        print("Cannot download file '" + s3_file + "' from the bucket '"
                + bucket + "': either bucket or file was not found")
        return False
    except NoCredentialsError:
        print("Cannot download file '" + s3_file + "' from the bucket '"
                + bucket + "': Credentials not available")
        return False

# Function to filter out K_MAX elements (by VAL) from the file of structure
# [KEY VAL] and print them out to the console
def filter_out_k_max_from_file(file_in, k_max):
    max_heap = []
    heap_size = 0
    with open (file_in, 'r' ) as f_in:
        while (line := f_in.readline().rstrip()):
            tokens = line.split()
            key = tokens[0]
            val = int(tokens[1])
            if(heap_size < k_max):
                heapq.heappush(max_heap,(val,key))
                heap_size += 1
            else:
                heapq.heappushpop(max_heap,(val,key))

        # due to there was no specific requirement about what to do if file size
        # is smaller than K - I will print out warning
        if(heap_size < k_max):
            print ("Warning! Input file did not have enough data to return all "
                    + str(k_max) + " keys, but only " + str(heap_size))

        return max_heap

if __name__ == '__main__':

    # Get file from S3, and put it into a working directory with the same name
    download_file_from_s3(FILE, BUCKET, ACCESS_KEY, SECRET_KEY)

    # run filter function
    try:
        max_keys = filter_out_k_max_from_file(FILE, K_MAX)
        # print out k_max keys
        for k in max_keys:
            print(k[1])
    except MemoryError:
        print("Memory Error while processing file '" + FILE + "'")

    # remove local copy of file
    try:
        os.remove(FILE)
    except FileNotFoundError:
        print("Could not find file '" + FILE + "' to remove it")
