/* TwoSum.cpp
Given an array of integers, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2.
Please note that your returned answers (both index1 and index2) are not zero-based.

You may assume that each input would have exactly one solution.

Input: numbers={2, 7, 11, 15}, target=9
Output: index1=1, index2=2
*/


class Solution {
public:
    vector<int> twoSum(vector<int> &N, int T) {

	std::map<int,int> map;
	std::vector<int> res;

	res.push_back(0);
	res.push_back(0);

	int size = N.size();
	int index;

	for (int i = 0; i < size; i++) {

		if(map.find(N[i]) != map.end()) {
			index = map[N[i]];
			res[0] = index + 1;
			res[1] = i + 1;
			break;
		} else {
			map[T - N[i]] = i;
		//	std::cout << "map[" << T - N[i] << "]=" << map[T - N[i]] << ", ";
		}
	}

	return res;

    }

};
