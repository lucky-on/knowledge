import argparse

# Create an ArgumentParser object
parser = argparse.ArgumentParser(description="Split a large text file into multiple files")

# Add the input file name argument
parser.add_argument("file_name", type=str, help="Name of the input file")

# Add the number of lines per file argument
parser.add_argument("lines_per_file", type=int, help="Number of lines per output file")

# Parse the command line arguments
args = parser.parse_args()

# Open the original file
with open(args.file_name, 'r') as original_file:
    # Get the total number of lines in the file
    total_lines = sum(1 for line in original_file)
    original_file.seek(0)
    # Calculate the number of files to be created
    num_files = total_lines // args.lines_per_file + 1
    # Iterate through the lines of the file
    for i in range(num_files):
        # Create a new file
        new_file = open(f"{i}.txt", "w")
        # Write the appropriate number of lines to the new file
        for line_number, line in enumerate(original_file):
            if line_number >= args.lines_per_file:
                break
            new_file.write(line)
        new_file.close()
