PopulateRightPointer.cpp

/**
 * Definition for binary tree with next pointer.
 * struct TreeLinkNode {
 *  int val;
 *  TreeLinkNode *left, *right, *next;
 *  TreeLinkNode(int x) : val(x), left(NULL), right(NULL), next(NULL) {}
 * };
 */
 
class Solution {
public:

    void connect(TreeLinkNode *root) {
        if (root == NULL) return;
        // descriptions guarantee that any node has children, so no need to check whether root has any, let's go
        
        TreeLinkNode *pre = root;
        TreeLinkNode *cur = NULL;
        
        //we will go by left wall and link the nodes from left to right on each level
        while(pre->left) {
            cur = pre;
            
            //this cycle will link all the next's in one level
            while(cur) { // description guarantee that all NEXT's are presetted a NULL
                cur->left->next = cur->right; // link children
                
                if(cur->next){ // here is a trick: comming from the top to down, start using NEXT pointers to link cusins
                    cur->right->next = cur->next->left;
                }
                
                cur = cur->next;
            }
            
            pre = pre->left;
        }
    }
};