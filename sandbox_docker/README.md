# What archive include:
1. k_max_filter.py - main script that does a job
2. Dockerfile
3. libs_to_install.txt - list of libraries to install by Docker
4. test files:
  4.1. canonical_keys.txt (10 keys we know that they correspond to max 10 values in the test files)
  4.2. sw-engineer-challenge_test_22.txt - files with 22 lines of [KEY VAL] pairs
  4.3. sw-engineer-challenge_test_2200.txt - files with 2200 lines of [KEY VAL] pairs
  4.4. k_max_filter_test.py - file with few tests to test business logic in k_max_filter.py using 4.1-4.3

# Assumptions
1. since there is a conflict in requirements `- Sort and return X largest values` and `Note that the output does not need to be in any particular order` I will follow the later one, also because there is no need to sort entire file, worth mentioning that it can be super expensive for big files.
2. You have Docker installed
3. You provided programatic access to S3 bucket with the file to process, means you know your bucket name, access and secret keys
4. File format is stable and it always [KEY VAL]

# Few clarifications about Dockerfile
1. I'm using slim variant of Python 3.8 to make the size of our final image smaller
2. List of required libs to install are in `libs_to_install.txt` file
3. Rule of thumb is not to run any scripts under root privileges, so I'm creating user `data_scientist` and script is ran by that user

# Build
1. Unzip file to directory `sergey_didenko`
2. go to `sergey_didenko` directory
3. Run `docker build -t woven_planet_sergey_didenko .` to build an image

# Run
1. `docker run --name k_max --rm woven_planet_sergey_didenko --bucket YOUR_BUCKET_NAME --file sw-engineer-challenge.txt --access_key YOUR_ACCESS_KEY --secret_key YOUR_SECRET_KEY --k_max 500`
2. What scrip do
  1.1. download file from S3
  1.2. parse it line by line (that way we can handle giant files)
  1.3. use max head data structure of fixed size (provided via --k_max argument) not to consume more memory than required
  1.4. print out keys associated with K_MAX values in the file in no particular order
  1.5. remove temporary local file
  1.6. print out a warning if number of lines in input file less than K_MAX
3. to run test locally run `python3 k_max_filter_test.py` (required Python3.8 or higher)
