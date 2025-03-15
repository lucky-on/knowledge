#!/usr/bin/env bash

-------------

Reminder: Users of this product must be members of the "vtune" group
to use the Hardware Event-based Sampling features.


To get started using Intel VTune Amplifier 2019 Update 6:
  - To set your environment variables:
    - csh/tcsh users: source
/opt/intel/vtune_amplifier_2019.6.0.602217/amplxe-vars.csh
    - bash users: source
/opt/intel/vtune_amplifier_2019.6.0.602217/amplxe-vars.sh
  - To start the graphical user interface: amplxe-gui
  - To use the command-line interface: amplxe-cl
  - For additional product configuration instructions, see the
    post-installation steps in the Intel VTune Amplifier
    Installation Guide:
/opt/intel/vtune_amplifier_2019.6.0.602217/documentation/en/
  - For more getting started resources:
/opt/intel/vtune_amplifier_2019.6.0.602217/documentation/en/welcomepage/get_star
ted.htm

To view movies and additional training, visit
http://www.intel.com/software/products

-------------

# disable kernel modules (that allowed me to see the thread name)
cd /opt/intel/vtune_amplifier/sepdk/src
$ sudo ./rmmod-sep

-------------

sudo addgroup vtune
sudo adduser didenkos vtune

# If not to install driver
sudo sh -c 'echo 0 >/proc/sys/kernel/perf_event_paranoid'

https://software.intel.com/en-us/vtune-amplifier-help-building-and-installing-the-sampling-drivers-for-linux-targets

# pipe
amplxe-cl -c memory-access -call-stack-mode=all -inline-mode=on -loop-mode=loop-and-function -r ~/vtune_results/ma_debug -- ~/work/pipe_fe/src/PryonPipeAudioToFeaturesLib/cbuild/tst/sys/systemTests --gtest_filter=PipeTestWithFiles.PushAudioAllAtOnceAllParallel_GetFeatures_NoCrash

#shim
amplxe-cl -c memory-access -call-stack-mode=all -inline-mode=on -loop-mode=loop-and-function -r ~/vtune_results/ma_shim_debug -- ~/work/pipe_fe_shim/PryonPipeAudioToFeaturesLib/cbuild/tst/sys/systemTests --gtest_filter=PipeTestWithFiles.PushAudioAllAtOnceAllParallel_GetFeatures_NoCrash


-loop-mode=loop-and-function (loop-only, function-only)
-search-dir=



-source-search-dir=
