#include <iostream>
#include <vector>

unsigned long long int Fibonachi(int fn, std::vector<unsigned long long int>* mem)
{
  if(fn == 0 || fn == 1) return fn;

  if(mem->size() < fn)
  {
    for(int i = mem->size(); i < fn; i++)
    {
      mem->push_back(mem->at(i-1) + mem->at(i-2));
      std::cout << mem->at(mem->size()-1) << std::endl;
    }
  }

  return mem->at(fn-1);
}


int main() {
    std::cout << "Let's do it!" << std::endl;

    std::vector<unsigned long long int> memoization{1,1};
    std::cout << Fibonachi(50, &memoization) << std::endl;

    return 0;
}
