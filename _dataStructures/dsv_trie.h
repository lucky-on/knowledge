//
// Created by Didenko, Sergey on 8/28/16.
//

#ifndef DATASTRUCTURES_DSV_TRIE_H
#define DATASTRUCTURES_DSV_TRIE_H

struct dsv_trie_node {



};

template <class Node_Type, class Val_Type> class dsv_trie {

public:
    unsigned int size;
    void insert(Node_Type node);
    Val_Type getVal(Node_Type node);



};


#endif //DATASTRUCTURES_DSV_TRIE_H
