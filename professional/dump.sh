22/22 Test #18: system_SentimentEngine/EngineFullPipelineSysTests.testPushSampleInputs//home/didenkos/SentimentSev2/src/SentimentCloudModels/configuration/models/beta/acolex/tst/audio/utt_0.wav ...***Failed    6.49 sec
Running main() from gtest_main.cc
Note: Google Test filter = SentimentEngine/EngineFullPipelineSysTests.testPushSampleInputs/0
[==========] Running 1 test from 1 test case.
[----------] Global test environment set-up.
[----------] 1 test from SentimentEngine/EngineFullPipelineSysTests
[ RUN      ] SentimentEngine/EngineFullPipelineSysTests.testPushSampleInputs/0
log4cxx: No appender could be found for logger (sentiment).
log4cxx: Please initialize the log4cxx system properly.
=================================================================
==89871==ERROR: AddressSanitizer: heap-use-after-free on address 0x6040001a3330 at pc 0x7f7d98cc886a bp 0x7f7d8f014b10 sp 0x7f7d8f014b08
READ of size 8 at 0x6040001a3330 thread T1220
    #0 0x7f7d98cc8869 in std::__detail::_Hash_code_base<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::__detail::_Select1st, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, true>::_M_bucket_index(std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> const*, unsigned long) const (/home/didenkos/SentimentSev2/build/PryonSwarm/PryonSwarm-1.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonSwarm.so.1+0x164869)
    #1 0x7f7d98cc5a63 in std::_Hashtable<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true> >::_M_bucket_index(std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true>*) const (/home/didenkos/SentimentSev2/build/PryonSwarm/PryonSwarm-1.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonSwarm.so.1+0x161a63)
    #2 0x7f7d98cc2d97 in std::_Hashtable<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true> >::_M_erase(unsigned long, std::__detail::_Hash_node_base*, std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true>*) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/hashtable.h:1786
    #3 0x7f7d98cbea47 in std::_Hashtable<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true> >::_M_erase(std::integral_constant<bool, true>, std::string const&) (/home/didenkos/SentimentSev2/build/PryonSwarm/PryonSwarm-1.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonSwarm.so.1+0x15aa47)
    #4 0x7f7d98cb904d in std::_Hashtable<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true> >::erase(std::string const&) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/hashtable.h:741
    #5 0x7f7d98cb4a16 in std::unordered_map<std::string, std::shared_ptr<pryon::swarm::Pool>, std::hash<std::string>, std::equal_to<std::string>, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > > >::erase(std::string const&) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/unordered_map.h:500
    #6 0x7f7d98ca96f6 in pryon::swarm::VirtualHardware::UnregisterPool(std::shared_ptr<pryon::swarm::Pool>) /home/didenkos/SentimentSev2/src/PryonSwarm/src/api/pryonswarm/virtual_hardware.cc:643
    #7 0x7f7d99cf6230 in pryon::pipe::PipeBase::~PipeBase() (/opt/brazil-pkg-cache/packages/PryonPipe/PryonPipe-4.2.236.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonPipe.so.1+0x34230)
    #8 0x7f7d99cf6558 in pryon::pipe::PipeBase::~PipeBase() (/opt/brazil-pkg-cache/packages/PryonPipe/PryonPipe-4.2.236.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonPipe.so.1+0x34558)
    #9 0x7f7da02b5700 in enginecommon::PryonAudioFeatExEngine::~PryonAudioFeatExEngine() (/opt/brazil-pkg-cache/packages/EngineCommonCpp/EngineCommonCpp-1.0.136.0/AL2012/DEV.STD.PTHREAD/build/lib/libengineCommonCpp.so.1+0x32700)
    #10 0x7f7da02b5938 in enginecommon::PryonAudioFeatExEngine::~PryonAudioFeatExEngine() (/opt/brazil-pkg-cache/packages/EngineCommonCpp/EngineCommonCpp-1.0.136.0/AL2012/DEV.STD.PTHREAD/build/lib/libengineCommonCpp.so.1+0x32938)
    #11 0x7f7d9ea1c256 in std::default_delete<enginecommon::AudioFeatExEngine>::operator()(enginecommon::AudioFeatExEngine*) const /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/unique_ptr.h:76
    #12 0x7f7d9ea1adf4 in std::unique_ptr<enginecommon::AudioFeatExEngine, std::default_delete<enginecommon::AudioFeatExEngine> >::~unique_ptr() /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/unique_ptr.h:236
    #13 0x7f7d9ea17d53 in sentiment::SentimentEngine::~SentimentEngine() /home/didenkos/SentimentSev2/src/SentimentEngineCpp/src/api/sentimentengine/sentiment_engine.cc:49
    #14 0x7f7d9ea17e55 in sentiment::SentimentEngine::~SentimentEngine() /home/didenkos/SentimentSev2/src/SentimentEngineCpp/src/api/sentimentengine/sentiment_engine.cc:52
    #15 0x49cf0a in std::default_delete<sentiment::SentimentEngine>::operator()(sentiment::SentimentEngine*) const (/local/home/didenkos/SentimentSev2/build/SentimentEngineCpp/SentimentEngineCpp-1.0/AL2012/DEV.STD.PTHREAD/build/private/tst/sys/systemTests+0x49cf0a)
    #16 0x499024 in std::unique_ptr<sentiment::SentimentEngine, std::default_delete<sentiment::SentimentEngine> >::~unique_ptr() (/local/home/didenkos/SentimentSev2/build/SentimentEngineCpp/SentimentEngineCpp-1.0/AL2012/DEV.STD.PTHREAD/build/private/tst/sys/systemTests+0x499024)
    #17 0x495650 in sentiment::EngineFullPipelineSysTests::runTests() (/local/home/didenkos/SentimentSev2/build/SentimentEngineCpp/SentimentEngineCpp-1.0/AL2012/DEV.STD.PTHREAD/build/private/tst/sys/systemTests+0x495650)
    #18 0x48a46b in sentiment::EngineFullPipelineSysTests_testPushSampleInputs_Test::TestBody()::{lambda()#1}::operator()() const (/local/home/didenkos/SentimentSev2/build/SentimentEngineCpp/SentimentEngineCpp-1.0/AL2012/DEV.STD.PTHREAD/build/private/tst/sys/systemTests+0x48a46b)
    #19 0x491c8d in _M_invoke<> /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/functional:1700
    #20 0x491882 in operator() /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/functional:1688
    #21 0x4915d9 in _M_run /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/thread:115
    #22 0x7f7d9e45843f in execute_native_thread_routine (/opt/brazil-pkg-cache/packages/LibStdCpp/LibStdCpp-gcc.213009.0/AL2012/DEV.STD.PTHREAD/build/lib/libstdc++.so.6+0xce43f)
    #23 0x7f7d9f022aa0 in start_thread (/lib64/libpthread.so.0+0x7aa0)
    #24 0x7f7d9dc42bdc in __clone (/lib64/libc.so.6+0xe8bdc)

0x6040001a3330 is located 32 bytes inside of 40-byte region [0x6040001a3310,0x6040001a3338)
freed by thread T1217 here:
    #0 0x7f7d9f292757 in operator delete(void*) (/opt/brazil-pkg-cache/packages/LibStdCpp/LibStdCpp-gcc.213009.0/AL2012/DEV.STD.PTHREAD/build/lib/libasan.so.1+0x5a757)
    #1 0x7f7d98cc5f53 in __gnu_cxx::new_allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> >::deallocate(std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true>*, unsigned long) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/ext/new_allocator.h:110
    #2 0x7f7d98cc23cf in std::allocator_traits<std::allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> > >::deallocate(std::allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> >&, std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true>*, unsigned long) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/alloc_traits.h:514
    #3 0x7f7d98cc2af6 in std::__detail::_Hashtable_alloc<std::allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> > >::_M_deallocate_node(std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true>*) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/hashtable_policy.h:1977
    #4 0x7f7d98cc3006 in std::_Hashtable<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true> >::_M_erase(unsigned long, std::__detail::_Hash_node_base*, std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true>*) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/hashtable.h:1796
    #5 0x7f7d98cbea47 in std::_Hashtable<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true> >::_M_erase(std::integral_constant<bool, true>, std::string const&) (/home/didenkos/SentimentSev2/build/PryonSwarm/PryonSwarm-1.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonSwarm.so.1+0x15aa47)
    #6 0x7f7d98cb904d in std::_Hashtable<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true> >::erase(std::string const&) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/hashtable.h:741
    #7 0x7f7d98cb4a16 in std::unordered_map<std::string, std::shared_ptr<pryon::swarm::Pool>, std::hash<std::string>, std::equal_to<std::string>, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > > >::erase(std::string const&) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/unordered_map.h:500
    #8 0x7f7d98ca96f6 in pryon::swarm::VirtualHardware::UnregisterPool(std::shared_ptr<pryon::swarm::Pool>) /home/didenkos/SentimentSev2/src/PryonSwarm/src/api/pryonswarm/virtual_hardware.cc:643
    #9 0x7f7d99cf6230 in pryon::pipe::PipeBase::~PipeBase() (/opt/brazil-pkg-cache/packages/PryonPipe/PryonPipe-4.2.236.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonPipe.so.1+0x34230)

previously allocated by thread T1217 here:
    #0 0x7f7d9f2922df in operator new(unsigned long) (/opt/brazil-pkg-cache/packages/LibStdCpp/LibStdCpp-gcc.213009.0/AL2012/DEV.STD.PTHREAD/build/lib/libasan.so.1+0x5a2df)
    #1 0x7f7d98cc5b26 in __gnu_cxx::new_allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> >::allocate(unsigned long, void const*) (/home/didenkos/SentimentSev2/build/PryonSwarm/PryonSwarm-1.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonSwarm.so.1+0x161b26)
    #2 0x7f7d98cc224d in std::allocator_traits<std::allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> > >::allocate(std::allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> >&, unsigned long) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/alloc_traits.h:488
    #3 0x7f7d98cbdf4b in std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true>* std::__detail::_Hashtable_alloc<std::allocator<std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> > >::_M_allocate_node<std::piecewise_construct_t const&, std::tuple<std::string const&>, std::tuple<> >(std::piecewise_construct_t const&, std::tuple<std::string const&>&&, std::tuple<>&&) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/hashtable_policy.h:1951
    #4 0x7f7d98cb8f2a in std::__detail::_Map_base<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > >, std::__detail::_Select1st, std::equal_to<std::string>, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, std::__detail::_Prime_rehash_policy, std::__detail::_Hashtable_traits<true, false, true>, true>::operator[](std::string const&) /brazil-pkg-cache/packages/CFlagsLive/CFlagsLive-1.0.212312.0/AL2012/DEV.STD.PTHREAD/build/gcc-4.9.4/include/c++/4.9.4/bits/hashtable_policy.h:601
    #5 0x7f7d98cb48a8 in std::unordered_map<std::string, std::shared_ptr<pryon::swarm::Pool>, std::hash<std::string>, std::equal_to<std::string>, std::allocator<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> > > >::operator[](std::string const&) (/home/didenkos/SentimentSev2/build/PryonSwarm/PryonSwarm-1.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonSwarm.so.1+0x1508a8)
    #6 0x7f7d98ca7d2e in pryon::swarm::VirtualHardware::RegisterPool(std::shared_ptr<pryon::swarm::Pool>) /home/didenkos/SentimentSev2/src/PryonSwarm/src/api/pryonswarm/virtual_hardware.cc:565
    #7 0x7f7d99cf4c86 in pryon::pipe::PipeBase::PipeBase(std::shared_ptr<pryon::pipe::PipeInfo const> const&, std::vector<std::unique_ptr<pryon::flow::Flow, std::default_delete<pryon::flow::Flow> >, std::allocator<std::unique_ptr<pryon::flow::Flow, std::default_delete<pryon::flow::Flow> > > >&&, std::unordered_map<std::type_index, std::unordered_map<std::string, std::function<void (pryon::pipe::IOData const&)>, std::hash<std::string>, std::equal_to<std::string>, std::allocator<std::pair<std::string const, std::function<void (pryon::pipe::IOData const&)> > > >, std::hash<std::type_index>, std::equal_to<std::type_index>, std::allocator<std::pair<std::type_index const, std::unordered_map<std::string, std::function<void (pryon::pipe::IOData const&)>, std::hash<std::string>, std::equal_to<std::string>, std::allocator<std::pair<std::string const, std::function<void (pryon::pipe::IOData const&)> > > > > > >&&, std::shared_ptr<pryon::swarm::ComputePool>, std::vector<std::unique_ptr<pryon::flow::EventHandler, std::default_delete<pryon::flow::EventHandler> >, std::allocator<std::unique_ptr<pryon::flow::EventHandler, std::default_delete<pryon::flow::EventHandler> > > >&&) (/opt/brazil-pkg-cache/packages/PryonPipe/PryonPipe-4.2.236.0/AL2012/DEV.STD.PTHREAD/build/lib/libpryonPipe.so.1+0x32c86)

Thread T1220 created by T0 here:
    #0 0x7f7d9f26094a in pthread_create (/opt/brazil-pkg-cache/packages/LibStdCpp/LibStdCpp-gcc.213009.0/AL2012/DEV.STD.PTHREAD/build/lib/libasan.so.1+0x2894a)
    #1 0x7f7d9e458560 in std::thread::_M_start_thread(std::shared_ptr<std::thread::_Impl_base>) (/opt/brazil-pkg-cache/packages/LibStdCpp/LibStdCpp-gcc.213009.0/AL2012/DEV.STD.PTHREAD/build/lib/libstdc++.so.6+0xce560)

Thread T1217 created by T0 here:
    #0 0x7f7d9f26094a in pthread_create (/opt/brazil-pkg-cache/packages/LibStdCpp/LibStdCpp-gcc.213009.0/AL2012/DEV.STD.PTHREAD/build/lib/libasan.so.1+0x2894a)
    #1 0x7f7d9e458560 in std::thread::_M_start_thread(std::shared_ptr<std::thread::_Impl_base>) (/opt/brazil-pkg-cache/packages/LibStdCpp/LibStdCpp-gcc.213009.0/AL2012/DEV.STD.PTHREAD/build/lib/libstdc++.so.6+0xce560)

SUMMARY: AddressSanitizer: heap-use-after-free ??:0 std::__detail::_Hash_code_base<std::string, std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, std::__detail::_Select1st, std::hash<std::string>, std::__detail::_Mod_range_hashing, std::__detail::_Default_ranged_hash, true>::_M_bucket_index(std::__detail::_Hash_node<std::pair<std::string const, std::shared_ptr<pryon::swarm::Pool> >, true> const*, unsigned long) const
Shadow bytes around the buggy address:
  0x0c088002c610: fa fa fd fd fd fd fd fa fa fa 00 00 00 00 00 fa
  0x0c088002c620: fa fa fd fd fd fd fd fa fa fa 00 00 00 00 07 fa
  0x0c088002c630: fa fa 00 00 00 00 03 fa fa fa fd fd fd fd fd fd
  0x0c088002c640: fa fa fa fa fa fa fa fa fa fa 00 00 00 00 03 fa
  0x0c088002c650: fa fa fd fd fd fd fd fa fa fa 00 00 00 00 01 fa
=>0x0c088002c660: fa fa fd fd fd fd[fd]fa fa fa 00 00 00 00 02 fa
  0x0c088002c670: fa fa fd fd fd fd fd fd fa fa fa fa fa fa fa fa
  0x0c088002c680: fa fa 00 00 00 00 02 fa fa fa fa fa fa fa fa fa
  0x0c088002c690: fa fa 00 00 00 00 01 fa fa fa fd fd fd fd fd fa
  0x0c088002c6a0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c088002c6b0: fa fa 00 00 00 00 01 fa fa fa fd fd fd fd fd fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Heap right redzone:      fb
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack partial redzone:   f4
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Contiguous container OOB:fc
  ASan internal:           fe
==89871==ABORTING

