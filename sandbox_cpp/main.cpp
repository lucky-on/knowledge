#include <vector>
#include <iostream>

using namespace std;

void Solution()
{
  vector<int> arr{-100,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,10,100};

  cout << "INT_MAX " << INT_MAX << endl;
  cout << "INT_MIN " << INT_MIN << endl;
  cout << "UINT_MAX " << UINT_MAX << endl;

  for(auto i : arr)
  {
    cout << i << " casted " << static_cast<unsigned>(i) << endl;
  }
  cout << "done!" << std::endl;
}

int main() {
    Solution();


    return 0;
}
