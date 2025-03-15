// FirstPositive.cpp

/*
Given an unsorted integer array, find the first missing positive integer.

For example,
Given [1,2,0] return 3,
and [3,4,-1,1] return 2.

Your algorithm should run in O(n) time and uses constant space.
*/

class Solution {
public:
    int firstMissingPositive(int A[], int n) {
        
        // idea here is to ignore negative values and put all positive values by their indexes
        for (int i = 0; i < n; ++i)
        {
            int d = A[i];
            while (d <= n && d > 0 && A[d - 1] != d)
            {
                swap(A[d - 1], A[i]);
                d = A[i];
            }
        }
        
        // find firt index with element which is not equal to this index+1
        for (int i = 0; i < n; ++i)
        {
            if (A[i] != i + 1)
            {
                return i + 1;
            }
        }
        
        return n + 1;
    }

};