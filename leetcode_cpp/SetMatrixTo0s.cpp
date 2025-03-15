/*SetMatrixTo0s.cpp

Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in place.


Follow up:
Did you use extra space?
A straight forward solution using O(mn) space is probably a bad idea.
A simple improvement uses O(m + n) space, but still not the best solution.
Could you devise a constant space solution?*/

class Solution {
public:
    void setZeroes(vector<vector<int> > &matrix) {
        
        if (matrix.empty()) return;
        int M = matrix.size();
        int N = matrix[0].size();
        
        int row=-1;
        bool markThisRow=false;
        
        for(int i=0; i<M; i++){
            for(int j=0; j<N; j++){
                if(matrix[i][j] == 0){
                    // for each 0-cell set all cells on top of it to 0s
                    for(int k=i-1; k>=0; k--)           { matrix[k][j] = 0; }
                    
                    markThisRow=true; // say "this Row need to be set to 0s"
                }else{
                    // set current cell to 0 only if cell on top of it is 0
                    if(i>0 && (matrix[i-1][j] == 0))    { matrix[i][j] = 0; }
                }
            }
            
            // if "previous" Row was marked - set that row to 0s
            if(markThisRow) {
                if(row >= 0) { setRow(matrix,row); }
                row=i; // set index of the current Row to set it later.
                markThisRow=false;
            }
        }
        
        // here we go, after all row has index of the latest row marked, so set all cell of it to 0s
        if(row >=0 ) setRow(matrix, row);
        
    }
    
    void setRow(vector<vector<int> > &m, int i){
        for(int j=0; j<m[i].size(); j++)    m[i][j]=0;
    }
};