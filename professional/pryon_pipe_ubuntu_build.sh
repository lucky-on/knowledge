https://it.amazon.com/en/help/articles/working-remotely-when-you-use-a-desktop-in-the-office

sudo apt-get install xrdp 
sudo systemctl enable xrdp 
sudo reboot


# run_test_under_calgrind.sh 

#!/bin/bash

#Shim
#valgrind --tool=callgrind ~/work/pipe_fe_shim/PryonPipeAudioToFeaturesLib/cbuild/tst/sys/systemTests --gtest_filter=PipeTestWithFiles.PushAudioAllAtOnceAllParallel_GetFeatures_NoCrash
#touch callgrind_shim_all_parallel_debug_done
valgrind --tool=callgrind ~/work/pipe_fe_shim/PryonPipeAudioToFeaturesLib/cbuild/tst/sys/systemTests --gtest_filter=PipeTestWithType.SingleBuilderStressTest_NoCrash
touch callgrind_shim_stress_debug_done

#Decoupled
#valgrind --tool=callgrind ~/work/pipe_fe/src/PryonPipeAudioToFeaturesLib/cbuild/tst/sys/systemTests --gtest_filter=PipeTestWithFiles.PushAudioAllAtOnceAllParallel_GetFeatures_NoCrash
#touch callgrind_decoupled_all_parallel_debug_done
valgrind --tool=callgrind ~/work/pipe_fe/src/PryonPipeAudioToFeaturesLib/cbuild/tst/sys/systemTests --gtest_filter=PipeTestWithType.SingleBuilderStressTest_NoCrash
touch callgrind_decoupled_stress_debug_done


# vtune_run_gui.sh 

#!/bin/bash
source /opt/intel/vtune_amplifier_2019.6.0.602217/amplxe-vars.sh
amplxe-gui


# watch pryon

#!/bin/bash
lsof -p $(ps aux | grep -i 'systemTest' | head -n 1 | awk '{print $2}') | grep '.so' | grep $1



# Build procedure for June - October 2019 experiment with Framework to run experiments with VTune and find out WHY October version is 3 times faster

1. Refer to this wikies to start with:
- https://wiki.labcollab.net/confluence/display/BLUES/Getting+set+up+with+Pryon%2C+focus+on+Ubuntu+and+Mac#GettingsetupwithPryon,focusonUbuntuandMac-BuildingOpenFstandKaldiforUbuntu
- https://wiki.labcollab.net/confluence/display/Doppler/Getting+set+up+with+NeMoRt%2C+focus+on+Ubuntu
-
=============

# disable ASan Address sanitizer
cmake -DSANITIZE_ADDRESS=OFF
# check if there are debug symbols in the library
nm -a ./PryonJson/cbuild/googletest-build/googlemock/libgmock_main.so | grep asan | wc
for each in $(find /home/ANT.AMAZON.COM/didenkos/work/pipe_fe_shim/install/ -name *.so.1.0); do echo $each; nm -a $each | wc && ls -sh $each; done

# fix error 12: cannot allocate memory
sudo sh -c 'echo 1 > /proc/sys/vm/overcommit_memory'

==============

# Build common packages
cd ~/work
brazil ws --create --name pryon_common --vs Pryon/Pipe-mini-live
cd pryon_common/
brazil ws --use --package PryonCMakeCommon
brazil ws --use --package PryonConfig
brazil ws --use --package PryonJson
cd src/PryonCMakeCommon/
bb

#PryonUtil
cd ../PryonUtil/
mkdir cbuild
cd cbuild
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release ../
ninja check
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug ../
ninja check
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release ../
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug ../
ninja install

cd ../PryonJson/
mkdir cbuild
cd cbuild
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release ../
ninja check
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug ../
ninja check
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release ../
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug ../
ninja install

cd ../PryonConfig/
mkdir cbuild
cd cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DRapidJSON_ROOT=$(brazil-path '[RapidJSON]pkg.libfarm') -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DRapidJSON_ROOT=$(brazil-path '[RapidJSON]pkg.libfarm') -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DRapidJSON_ROOT=$(brazil-path '[RapidJSON]pkg.libfarm') -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DRapidJSON_ROOT=$(brazil-path '[RapidJSON]pkg.libfarm') -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja install


# Specific for June version (Pryon + Shim Node + FELib)

# build pugixml
~/work/pipe_fe_shim/pugixml/cbuild$ rm -rf * && cmake -DBUILD_SHARED_LIBS=ON -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=OFF -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=./install -GNinja ../third-party-src/scripts/
ninja check
ninja install

#link PryonPugixml to pugixml
~/work/pipe_fe_shim/PryonPugixml$ ln -s ../pugixml/cbuild/install/ install

#NeMoRt
https://wiki.labcollab.net/confluence/display/Doppler/Getting+set+up+with+NeMoRt%2C+focus+on+Ubuntu
https://code.amazon.com/packages/PryonContainerBuildScripts/blobs/heads/ubuntu-branch/--/container-build-nemort

~/work/pipe_fe_shim/NeMoRt$ sudo ./install_nemort.sh ~/work/pipe_fe_shim/NeMoRt/build/install -j 12

sudo cp -r /home/ANT.AMAZON.COM/didenkos/work/pryon/NeMoRtLib/cbuild/install/include/nemort /usr/local/include
# install gtest required by NeMoRt
https://code.amazon.com/packages/PryonBuildImage/blobs/mainline/--/install_manual_dependencies.sh

cd src/nemort/kaldi/
vim kaldi.mk

# Add to
# Common CXXFlags for all platforms
CXXFLAGS += -Wno-unused-local-typedefs -I$(KALDI_PATH)/src -DBOOST_VARIANT_USE_RELAXED_GET_BY_DEFAULT

~/work/pipe_fe_shim/NeMoRt$ ./clean_nemort.sh
~/work/pipe_fe_shim/NeMoRt$ sudo ./install_nemort.sh ~/work/pipe_fe_shim/NeMoRt/build/install -j 12

# install Google protocol buffers packages
sudo dpkg --install ~/tools/libprotobuf8_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotobuf-dev_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotobuf-lite8_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotoc8_2.5.0-9ubuntu1_amd64.deb ~/tools/libprotoc-dev_2.5.0-9ubuntu1_amd64.deb ~/tools/protobuf-compiler_2.5.0-9ubuntu1_amd64.deb

# build PryonG2P on Ubuntu
https://code.amazon.com/packages/PryonG2P/blobs/mainline/--/INSTALL.md

cd ~/work/pipe_fe_shim/PryonG2P
mkdir cbuild
cd cbuild
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCODE_COVERAGE=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DPRYONOPENFST_ROOT=/usr/local -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release ../
ninja check
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCODE_COVERAGE=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DPRYONOPENFST_ROOT=/usr/local -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug ../
ninja check
ninja install


sudo apt-get install valgrind
make memcheck

# PryonFstBuilder
https://code.amazon.com/packages/PryonFstBuilder/trees/mainline

cd ~/work/pipe_fe_shim/PryonFstBuilder
mkdir cbuild
cd cbuild
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DPRYONOPENFST_ROOT=/usr/local -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=OFF -DCMAKE_BUILD_TYPE=RelWithDebInfo -DPryonUtil_ROOT=/home/ANT.AMAZON.COM/didenkos/work/pipe_fe_shim/install/release -DPryonPugixml_ROOT=/home/ANT.AMAZON.COM/didenkos/work/pipe_fe_shim/PryonPugixml/install -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release ../
ninja check
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DPRYONOPENFST_ROOT=/usr/local -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=OFF -DPryonUtil_ROOT=/home/ANT.AMAZON.COM/didenkos/work/pipe_fe_shim/install/debug -DPryonPugixml_ROOT=/home/ANT.AMAZON.COM/didenkos/work/pipe_fe_shim/PryonPugixml/install -DCMAKE_BUILD_TYPE=Debug  -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug ../
ninja check
ninja install

# PryonFlowNodeInterfaces
cd ~/work/pipe_fe_shim/PryonFlowNodeInterfaces
mkdir cbuild
cd cbuild
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=OFF  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release ../
ninja check
ninja install
rm -rf * && cmake -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=OFF  -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug ../
ninja check
ninja install

# Pryon
cd ~/work/pipe_fe_shim/Pryon/pryon$
pypa
op/scons -j 12 -k KALDI_ROOT=/usr/local OPENFST_ROOT=/usr/local PUGIXML_ROOT=$HOME/work/pipe_fe_shim/pugixml/cbuild/install NEMORT_ROOT=$HOME/work/pipe_fe_shim/NeMoRt/build/install G2P_ROOT=$HOME/work/pipe_fe_shim/install/release GRXML_PARSER_ROOT=$HOME/work/pipe_fe_shim/install/release PRYONJSON_ROOT=$HOME/work/pipe_fe_shim/install/release PRYONUTIL_ROOT=$HOME/work/pipe_fe_shim/install/release ENABLE_NEMORT_LIB=1 BUILD_TYPE=release SYMBOLS=1
op/scons -j 12 -k KALDI_ROOT=/usr/local OPENFST_ROOT=/usr/local PUGIXML_ROOT=$HOME/work/pipe_fe_shim/pugixml/cbuild/install NEMORT_ROOT=$HOME/work/pipe_fe_shim/NeMoRt/build/install G2P_ROOT=$HOME/work/pipe_fe_shim/install/debug GRXML_PARSER_ROOT=$HOME/work/pipe_fe_shim/install/debug PRYONJSON_ROOT=$HOME/work/pipe_fe_shim/install/debug PRYONUTIL_ROOT=$HOME/work/pipe_fe_shim/install/debug ENABLE_NEMORT_LIB=1 BUILD_TYPE=debug SYMBOLS=1

# Copy Pryon artifacts to common location
cd ~/work/pipe_fe_shim/Pryon/pryon/build/linux2-posix-x86_64-64bit-le/mainline/debug/install$
cp -v lib/* ~/work/pipe_fe_shim/install/debug/lib/
cd ~/work/pipe_fe_shim/Pryon/pryon/build/linux2-posix-x86_64-64bit-le/mainline/release/install$
cp -v lib/* ~/work/pipe_fe_shim/install/release/lib/

# Pryon building PryonFrontEndShim package Pipe package is required and we can use the latest version of it
# (it was only depending on Exceptions back then)
# But in order to build PryonPipe both PryonNode and PryonFlow should be built

cd ~/work/pipe_fe/src/PryonNode/
mkdir cbuild
cd cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DBRAZIL_GTEST_SETUP=Off -DSANITIZE_ADDRESS=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

cd ~/work/pipe_fe/src/PryonFlow/
mkdir cbuild
cd cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

# PryonPipe

cd ~/work/pipe_fe/src/PryonPipe/
mkdir cbuild
cd cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DPryonFlow_ROOT=$HOME/work/pipe_fe/install/release -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DPryonFlow_ROOT=$HOME/work/pipe_fe/install/debug -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DPryonFlow_ROOT=$HOME/work/pipe_fe/install/release -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DPryonFlow_ROOT=$HOME/work/pipe_fe/install/debug -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug
ninja check
ninja install

# PryonFrontEndShimNode
cd ~/work/pipe_fe/src/PryonFrontEndShimNode/
git checkout 1c285efa2e8d404e03d403504b71721885144e80
mkdir cbuild
cd cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonFlowNodeInterfaces_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryon_ROOT=$HOME/work/pipe_fe_shim/Pryon/pryon/build/linux2-posix-x86_64-64bit-le/mainline/release/install -DPryonPipe_ROOT=$HOME/work/pipe_fe_shim/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/release
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonFlowNodeInterfaces_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryon_ROOT=$HOME/work/pipe_fe_shim/Pryon/pryon/build/linux2-posix-x86_64-64bit-le/mainline/debug/install -DPryonPipe_ROOT=$HOME/work/pipe_fe_shim/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe_shim/install/debug
ninja install

# PryonPipeAudioToFeaturesLib
cd ~/work/pipe_fe_shim/src/PryonPipeAudioToFeaturesLib/
git checkout 64c17818a40194f3710fc76eff0bf97de28cec72
mkdir cbuild
cd cbuild
rm -rf * && env CXXFLAGS="-Wl,-rpath,$HOME/work/pipe_fe_shim/install/release/lib -Wl,-rpath-link,$HOME/work/pipe_fe_shim/install/release/lib" cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonFlowNodeInterfaces_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonFrontEndShimNode_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonPipe_ROOT=$HOME/work/pipe_fe_shim/install/release -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release -DLIBSNDFILE_LIB_PATH=/usr/lib/x86_64-linux-gnu
ninja check
ninja install

rm -rf * && env CXXFLAGS="-Wl,-rpath,$HOME/work/pipe_fe_shim/install/debug/lib -Wl,-rpath-link,$HOME/work/pipe_fe_shim/install/debug/lib" cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonFlowNodeInterfaces_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonFrontEndShimNode_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonPipe_ROOT=$HOME/work/pipe_fe_shim/install/debug -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug -DLIBSNDFILE_LIB_PATH=/usr/lib/x86_64-linux-gnu
ninja check
ninja install


# October version (Framework + Nodes + FE Lib)

# By that time PryonNode, PryonFlow, PryonSwarm and PryonPipe are already built

cd ~/work/pipe_fe/src/PryonPrimitives/cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

cd ~/work/pipe_fe/src/PryonNodeAudioFramer/cbuild

rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

cd ~/work/pipe_fe/src/PryonNodeFeatureExtractor/cbuild

rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

cd ~/work/pipe_fe/src/PryonSerializationMM/cbuild

rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DLIBARCHIVE_LIB_PATH=/usr/lib/x86_64-linux-gnu -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DLIBARCHIVE_LIB_PATH=/usr/lib/x86_64-linux-gnu -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

cd ~/work/pipe_fe/src/PryonNodeChannelNorm/cbuild

rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/release -DPryonSerializationMM_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/debug -DPryonSerializationMM_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

cd ~/work/pipe_fe/src/PryonNodeResultBuilderFE/cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryon-ATLAS_ROOT=/usr -DPryonUpstream_ROOT=/usr/local -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DPryonPrimitives_ROOT=$HOME/work/pipe_fe/install/debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install

cd ~/work/pipe_fe/src/PryonPipeAudioToFeaturesLib
cd cbuild
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/release -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/release -DPryonNode_ROOT=$HOME/work/pipe_fe/install/release -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DPryonPipe_ROOT=$HOME/work/pipe_fe/install/release -DPryonNodeAudioFramer_ROOT=$HOME/work/pipe_fe/install/release -DPryonNodeFeatureExtractor_ROOT=$HOME/work/pipe_fe/install/release -DPryonNodeChannelNorm_ROOT=$HOME/work/pipe_fe/install/release -DPryonNodeResultBuilderFE_ROOT=$HOME/work/pipe_fe/install/release -DLIBSNDFILE_LIB_PATH=/usr/lib/x86_64-linux-gnu -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/release
ninja check
ninja install
rm -rf * && cmake ../ -GNinja -DPRYON_CMAKE_COMMON=$HOME/work/pryon_common/src/PryonCMakeCommon -DCPPCHECK=Off -DSANITIZE_ADDRESS=Off -DBRAZIL_GTEST_SETUP=Off -DPryonUtil_ROOT=$HOME/work/pipe_fe/install/debug -DPryonConfig_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNode_ROOT=$HOME/work/pipe_fe/install/debug -DPryonSwarm_ROOT=$HOME/work/pipe_fe/src/PryonSwarm/cbuild/install -DPryonPipe_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNodeAudioFramer_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNodeFeatureExtractor_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNodeChannelNorm_ROOT=$HOME/work/pipe_fe/install/debug -DPryonNodeResultBuilderFE_ROOT=$HOME/work/pipe_fe/install/debug -DLIBSNDFILE_LIB_PATH=/usr/lib/x86_64-linux-gnu -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$HOME/work/pipe_fe/install/debug
ninja check
ninja install


#=====================

LD_LIBRARY_PATH=/Volumes/Work/Pipe/src/PryonUtil/cmake-build-debug/install/lib:/Volumes/Work/Pipe/src/PryonConfig/cmake-build-release/install/lib:/Volumes/Work/Pipe/src/PryonNode/cmake-build-debug/install/lib:/Volumes/Work/Pipe/src/PryonFlow/cmake-build-debug/install/lib:/Volumes/Work/Pipe/src/PryonSwarm/cmake-build-debug/install/lib

brazil-build cmake -DBRAZIL_GTEST_SETUP=Off -DBRAZIL_LIBFARM_DISABLED=On -DENABLE_CODE_COVERAGE=Off
BRAZIL_BUILD_ROOT=$HOME/.toolbox

-DBRAZIL_GTEST_SETUP=Off -DENABLE_CODE_COVERAGE=Off -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DPRYON_CMAKE_COMMON=/Volumes/Work/Pipe/src/PryonCMakeCommon -DPryonUtil_ROOT=/Volumes/Work/Pipe/src/PryonUtil/cmake-build-debug/install -DPryonConfig_ROOT=/Volumes/Work/Pipe/src/PryonConfig/cmake-build-release/install -DPryonNode_ROOT=/Volumes/Work/Pipe/src/PryonNode/cmake-build-debug/install -DPryonFlow_ROOT=/Volumes/Work/Pipe/src/PryonFlow/cmake-build-debug/install -DPryonSwarm_ROOT=/Volumes/Work/Pipe/src/PryonSwarm/cmake-build-debug/install -DPryonNodeLogger_ROOT=/Volumes/Work/Pipe/src/PryonNodeLogger/cmake-build-debug/install

LD_LIBRARY_PATH=/Volumes/Work/Pipe/src/PryonUtil/cmake-build-debug/install/lib:/Volumes/Work/Pipe/src/PryonConfig/cmake-build-release/install/lib:/Volumes/Work/Pipe/src/PryonNode/cmake-build-debug/install/lib:/Volumes/Work/Pipe/src/PryonFlow/cmake-build-debug/install/lib:/Volumes/Work/Pipe/src/PryonSwarm/cmake-build-debug/install/lib


-DBRAZIL_GTEST_SETUP=OFF
-DCODE_COVERAGE=Off
-DCMAKE_EXPORT_COMPILE_COMMANDS=ON
-DBRAZIL_GTEST_SETUP=Off
-DPRYON_CMAKE_COMMON=/Volumes/Work/Pipe/src/PryonCMakeCommon
