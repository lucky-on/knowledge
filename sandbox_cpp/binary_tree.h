/*
#include "binary_tree.h"

TreeNode* root = CreateTree();
PrintPreorder(root);
PrintPostorder(root);
PrintInorder(root);
std::cout << "size " << Size(root) << std::endl;
std::cout << "depth " << Depth(root) << std::endl;
std::cout << "min " << MinVal(root) << std::endl;
std::cout << "max " << MaxVal(root) << std::endl;
*/

struct tnode
{
    int data;
    struct tnode *left;
    struct tnode *right;
};

typedef struct tnode TreeNode;

TreeNode *NewItem(int data)
{
    TreeNode *pn = new TreeNode();
    pn->data = data;
    pn->left = 0;
    pn->right = 0;

    return pn;
}
TreeNode* InsertTree(TreeNode *pn, int data)
{
    if (!pn)
    {
      return NewItem(data);
    }

    else
    {
        if (data <= pn->data)
            pn->left = InsertTree(pn->left, data);

        else
            pn->right = InsertTree(pn->right, data);
    }

    return  pn;
}

TreeNode *CreateTree()
{
    TreeNode * pr = InsertTree(0, 4);
    InsertTree(pr, 1);
    InsertTree(pr, 2);
    InsertTree(pr, 3);
    InsertTree(pr, 5);
    InsertTree(pr, 6);

    return pr;
}

void PrintPreorder(TreeNode *pn)
{
    if (pn)
    {
        printf("preorder = %d\n", pn->data);
        PrintPreorder(pn->left);
        PrintPreorder(pn->right);
    }
}

void PrintPostorder(TreeNode *pn)
{
    if (pn)
    {
        PrintPostorder(pn->left);
        PrintPostorder(pn->right);
        printf("postorder = %d\n", pn->data);
    }
}

void PrintInorder(TreeNode *pn)
{
    if (pn)
    {
        PrintInorder(pn->left);
        printf("inorder = %d\n", pn->data);
        PrintInorder(pn->right);
    }
}

int Size(TreeNode *pn)
{
    if (pn)
    {
      return 1 + Size(pn->left) + Size(pn->right);
    }
    else
    {
      return 0;
    }
}

int Depth(TreeNode *pn)
{
    if (pn)
    {
        int ld = Depth(pn->left);
        int rd = Depth(pn->right);

        if (ld > rd)
        {
          return ld + 1;
        }
        else
        {
          return rd + 1;
        }
    }
    else
        return 0;
}

int MinVal(TreeNode *pn)
{
    if (pn)
    {
        while(pn->left)
        {
          pn = pn->left;
        }

        return pn->data;
    }
    else
    {
      return 0;
    }
}

int MaxVal(TreeNode *pn)
{
    if(pn)
    {
        while(pn->right)
        {
          pn = pn->right;
        }

        return pn->data;
    }
    else
    {
      return 0;
    }
}
