/*
#include "read_file.h"

std::vector<std::string> lines = ReadFileToVectorOfStrings("/Users/didenkos/sandbox_cpp/lines_of_text.txt");
for(const auto& line : lines)
{
  std::cout << line << std::endl;
}
*/

#include <fstream>
#include <string>
#include <vector>

std::vector<std::string> ReadFileToVectorOfStrings(std::string path)
{
  std::vector<std::string> result;

  std::cout << "reading file " << path << std::endl;

  std::ifstream file(path);
  std::string line;

  while (file >> line)
  {
    std::cout << "reading line " << line << std::endl;
    result.emplace_back(line);
  }
  return result;
}
