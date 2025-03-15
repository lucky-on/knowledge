from k_max_filter import filter_out_k_max_from_file

def compare_keys(keys_result, file_with_canonical_keys):
    # compare results with canonical file
    with open(file_with_canonical_keys) as file:
        keys_canonical = file.readlines()
        keys_canonical = [key.rstrip() for key in keys_canonical]
        keys_canonical.sort()
        if(keys_result == keys_canonical):
            print("   PASS!")
        else:
            print("   FAILED!")

def test_with_file(file):
    print("Test with file " + file)
    max_keys = []
    # run filter function
    try:
        tuples = filter_out_k_max_from_file(file, 10)
        for k in tuples:
            max_keys.append(k[1])
        max_keys.sort()
    except MemoryError:
        print("Memory Error while processing file '" + FILE + "'")
    return max_keys


if __name__ == '__main__':
    test_result = test_with_file("sw-engineer-challenge_test_9.txt")
    compare_keys(test_result, "canonical_keys_9.txt")

    test_result = test_with_file("sw-engineer-challenge_test_22.txt")
    compare_keys(test_result, "canonical_keys_10.txt")

    # should be able to handle
    test_result = test_with_file("sw-engineer-challenge_test_2200.txt")
    compare_keys(test_result, "canonical_keys_10.txt")

    # should return empty list
    test_result = test_with_file("sw-engineer-challenge_test_empty.txt")
    if(test_result == []):
        print("   PASS!")
    else:
        print("   FAILED!")
