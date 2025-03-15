#!/usr/bin/env bash

# set LD_LIBRARY_PATH to where all libs are
export LD_LIBRARY_PATH=$(brazil-path testrun.runtimefarm)/lib;

# run system tests under GDB
gdb --args ./build/private/tst/sys/systemTests --gtest_filter=EngineFullPipelineSysTests.testPushSampleInputs