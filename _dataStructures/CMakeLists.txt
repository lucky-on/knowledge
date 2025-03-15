cmake_minimum_required(VERSION 3.6)
project(DataStructures)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES main.cpp dsv_trie.cpp dsv_trie.h)
add_executable(DataStructures ${SOURCE_FILES})