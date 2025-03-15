#!/usr/bin/env bash

# CLion

# 1- Point to Pryon/src/Pryon
# 2- add to CMakeList.txt

include_directories(
        pryon/cpp
        pryon/cpp/external
        pryon/test/unit
)

# 3 - run
brazil-package-cache enable_edge_cache
brazil-path testbuild.includedirs

# - 4 add output to CMakeList like

# install Google protocol buffers packages
sudo dpkg --install ~/tools/libprotobuf8_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotobuf-dev_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotobuf-lite8_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotoc8_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotoc-dev_2.5.0-9ubuntu1_amd64.deb ~/tools/protobuf-compiler_2.5.0-9ubuntu1_amd64.deb

# after talking to Kyle
export LD_LIBRARY_PATH=$(brazil-path testrun.lib)
brazil-recursive-cmd -all "rm -rf build/private && brazil-build optimized_install"
