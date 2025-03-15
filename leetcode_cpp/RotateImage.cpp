// RotateImage.cpp

/*
You are given an n x n 2D matrix representing an image.

Rotate the image by 90 degrees (clockwise).

Follow up:
Could you do this in-place?
*/

class Solution {
public:
    void rotate(vector<vector<int> > &matrix) {
        
        int n = matrix.size();
        
        for(int i=0; i<n/2; i++){
            int layer = i;         
            int last = n - layer - 1;  // last number from the right
            
            for(int j = layer; j < last; j++){
                int o = j-layer; // o - offset, we need to move by the line starting from some index, so we need offset variable
                
                // start to copy items clockwise, save top, left -> top, bottom-> left, right->buttom, top->right
                int top=matrix[layer][j];
                // left -> top
                matrix[layer][j] = matrix[last-o][layer];
                // buttom -> left
                matrix[last-o][layer] = matrix[last][last-o];
                // right -> buttom
                matrix[last][last-o] = matrix[j][last];
                //top -> right
                matrix[j][last] = top;
            }
            
        }
    }
};