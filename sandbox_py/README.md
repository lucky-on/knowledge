1. List the observations and assumptions you made about the log file (3-5 sentences)
I found all different kind of formats used for DOB:
- mix of single and double digits for day and month
- mix of 2 and 4 digits for year
- mix of digits and literals for month
- mix of positions for day, month and year
- mix of using space, - and / as a delimiters between day, month and year
- mix of using digits only and digits + literals 'th' and 'rd' for days
- as well as some DOB contain just stars which we probably also want to normalize to, say "XX/XX/XXXX" (since it is unknown), that will simplify our logic in other scripts that process these files

2. What are some limitations of your solution and how would you fix them? (3-5 sentences)
- I did not catch all possible combinations, that can be fixed with more comprehensive regex, or, for better maintainability, few separate regexes to catch different cases if previous did not catch it.
- I do not process file line by line, reading files line by line will resolve "out_of_memory" problem when dealing with giant files

3. What steps did you take to verify your solution works as intended? (3-5 sentences)
- Initially I grab DOB= likes with my IDE and run regular expression I'm using
- But ideally I would add tests to cover all possible patters and to make sure my function "process_file_to_anonymize_dob" catches them all

4. How would you restructure your solution on a systems level to handle a high volume of very large log files? (short paragraph)
1. I would modify processing function to deal with strings as input and output, that way I can reuse it for small and large files.
2. I would add one more layer as a wrapper around file processing logic that would be responsible for reading the files from (potentially) different buckets and invoking (potentially) different processing routines, anonymizing DOB can be one of them.
3. Then I would add a logic that check file size and if it is above certain size - reads it line by line otherwise reads as a whole and invokes processing function.

5. Additionally, how would your testing process differ for a production-ready project? (short paragraph)
As a part of building the entire solution routine I would have integration tests that invokes function "process_file_to_anonymize_dob" against different strings that contain all possible combinations of validate the output agains known canonical string(s).
