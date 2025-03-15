#include <string>
#include <iostream>
#include <utility>


std::pair<std::string,std::string> split_by_two(const std::string& str, std::string delim)
{
  std::pair<std::string,std::string> result = std::make_pair("","");

  size_t found = str.find(delim);

  if (found != std::string::npos)
  {
      result = std::make_pair(str.substr(0,found), str.substr(found+1, std::string::npos));
  }
  return result;
}

int main() {
    auto pair_of_strings = split_by_two("string1:string2", ":");
    std::cout <<  pair_of_strings.first << std::endl << pair_of_strings.second << std::endl;

    return 0;
}
