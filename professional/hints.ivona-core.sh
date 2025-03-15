gerit6	 - All Amazon FireOS
gerit-blizzard - ivona core, voices IVONA repo
gerit		- ext


# Torque
	ssh ivona-torque-master.corp
#1
	sudo -iu ivobuild
		cd storage/voices/voice_en_us_nina/
		qstat
		qstat -f 5311

#2 to run the job manually
	ssh torque
	sudo logbash
	PATH=$PATH:/apollo/env/IvonaTorqueMaster/bin/
	export LD_LIBRARY_PATH=/apollo/env/IvonaTorqueMaster/lib
	qrun GOB_ID

# Blizzard
	ssh blizzard.aka
	sudo -iu voices

# PDBS Ubuntu
	ssh pdbs-ubuntu@pdbs.aka.amazon.com
	PW: AlaMa#Wielblada

# Mac Jenkins slave
PW: WhatNic23Cenic

# Passwords, PW
https://w.amazon.com/index.php/IVONA/P3/InsiderKnowledge

# To mount encrypted volume and start all services after boot of pdbs:
$ sudo /root/go.sh
// The password for the LUKS volume (it’s Jacek’s old password for cumulus):
lodylumalodylumalodylumalodyluma

#PDBS aka Amazon
	ssh didenkos@pdbs.aka.amazon.com

	# cd /home/ivona-pd/
	# sudo vim .ssh/authorized_keys
	# add my key from (less .ssh/id_rsa.pub)

#PDBS
	ssh didenkos@pdbs.aka.amazon.com
/rhel5pdi/ivona_sdk/ivona_core/master/ - releases
/rhel5pdi - old SDKs and apollo stuff
/gerrit - jenkins


====

# clone ivona core
	git clone ssh://gerrit-blizzard.aka.amazon.com:29418/ivona-core ivona-coreRelease --reference ivona-core
	ln -s ../ext; ln -s ../voxdb_archive/

# configure ivona-core
	rm -rf build; engine/tools/release -b Debug -p x86_64-pc-linux-gnu-ttsservice-alexa -j 8 -d no build
	rm -rf build; engine/tools/release -b Debug -p x86_64-pc-linux-gnu-parrot -j 8 -d no build

# build ext
	git clone ssh://gerrit.aka.amazon.com:29418/ext
	cd ext
	./ext sdk; ./ext openfst; ./ext phonetisaurus; ./ext libogg; ./ext libvorbis; ./ext pryon; ./ext mecab; ./ext crfpp

# Build ext for exact platform
	PLATFORM=x86_64-pc-linux-gnu ./ext sdk nemo

# Jenkins skripts
	git clone ssh://gerrit-blizzard.aka.amazon.com:29418/jenkins-scripts

#download voices (rub it from Debug or Release folder)
	make download-all
	make download-vox_en_us_nina

# test interpratation
	../../../engine/testsuite/interpretation/test_interpretation -v en_us_nina -i --debug-lex

	echo "<ivona:domain name='speechcon'><w role="ivona:speechcon">bon appetit</w></ivona:domain>" | ../../../engine/testsuite/interpretation/test_interpretation -v	en_us_nina -i --debug-lex
	echo "<w role='ivona:city'>Tecumseh</w>" | ../../../engine/testsuite/interpretation/test_interpretation -v en_us_nina -i --debug-lex

# syntethis from phonemes
	engine/testsuite/test_streamer -v en_us_nina -t '<ivona:domain name="speechcon"><phoneme alphabet="ipa" ph="t&#x259;mei&#x325;&#x27E;ou&#x325;'>

# Explore VOX DB
	less ../../../voxdb_archive/vox_en_us_nina/1461912866/vox_en_us_nina.chunks

	echo '<ivona:domain name="joke"> Why don'\''t people eat clocks? It'\''s too time consuming! </ivona:domain>' | engine/tools/ivona_dump_ta/ivona_dump_ta -C ../../../engine/data/licenses/unlimited-1.5.txt -l engine/voices/libvoice_en_us_nina.so -x ../../../voxdb_archive -D engine/lexicons/  --dump-diphones --dp-seq ~/TTS_Domains/test/VoxDB_Jokes_fails2.txt -w ~/TTS_Domains/test/VoxDB_Jokes_fails2.wav && less ~/TTS_Domains/test/VoxDB_Jokes_fails2.txt  | ../../../core/tools/voxtool

# Jenkins
	Master server
		https://pdbs.aka.amazon.com/computer/(master)/

# Apollo environment
	https://apollo.amazon.com/environments/IvonaTorqueMaster

# To profile ivona-core, Valgrind
    sudo apt-get install valgrind
    sudo apt-get install kcachegrind

    valgrind --tool=callgrind engine/testsuite/test_streamer -v en_us_nina -i ~/Dnn.txt -o 1.wav
    kcachegrind callgrind.out.27303

	valgrind --tool=callgrind engine/testsuite/test_streamer -p num_parallel_threads=4 -v en_us_nina -i ~/Projects/samples/Dnn1.txt -o 1.wav

	valgrind --tool=callgrind engine/testsuite/test_streamer -v en_us_nina -i ~/Projects/samples/Dnn1.txt -o 1.wav

	valgrind --tool=callgrind engine/tools/ivona_dump_ta/ivona_dump_ta -l engine/voices/libvoice_en_us_nina.so -x ../../../voxdb_archive -C ../../../engine/data/licenses/unlimited-1.5.txt -D engine/lexicons/ -i ~/Projects/samples/Dnn1.txt -w 1.wav

# benchmark
	engine/testsuite/test_streamer -v en_us_nina -i ~/Projects/samples/Dnn1.txt -b benchmark.txt -S 22050
	less benchmark.txt


# to measure test_streamer overall performance
engine/testsuite/test_streamer -v en_us_nina -i ~/Dnn.txt -n 5 -q -0 -S 22050
The output will look like this

Sample 01: 43.140499 seconds of speech synthesized in 6.383  (ignore for a while, since first run it takes time to "warm up", not related to performance of the algorithms we are measuring)
Sample 02: 43.140499 seconds of speech synthesized in 4.292
Sample 03: 43.140499 seconds of speech synthesized in 4.304
Sample 04: 43.140499 seconds of speech synthesized in 4.327
Sample 05: 43.140499 seconds of speech synthesized in 4.294
average times faster than real-time: 9.139936
(43.140499 seconds of speech synthesized in average 4.720000)

Keep in mind to measure with Release or RelWithDebug version.


engine/testsuite/test_streamer -v en_us_nina -i ~/Projects/samples/Dnn1.txt -b Dnn1_out.txt -S 22050 -q --dump-metrics-first-bytes --dump-metrics > 2_Metrics_ChangeDuration.txt


# normalize text
0) https://w.amazon.com/index.php/IVONA/Core/Tools+For+TTS+Linguists#test_interpretation

1) prepare your text
File VoxDB_Jokes_List_all.txt should contain the text like this

( ivona_set_blah "text to normalize" "" )
set name does not matter

run

ivona-core...Debug$ ../../../engine/testsuite/interpretation/test_interpretation -v dummy-en-US --dump-words
--test ~/Projects/samples/VoxDB_Jokes_List_all.txt 2>&1 | tee ~/Projects/samples/VoxDB_Jokes_List_all_words.txt

../../../engine/testsuite/interpretation/test_interpretation -v [voice name: dummy-en-US or en_us_nina for American English] --dump-words --test [file_path]

2) when you do normalize the stuff from txt.done.data you need to get rid of the PSAs and put the words back in.
this Perl command should do it
s/\PSA{([^,]+),[^}]+}/$1/g
if you use vim that has perl compiled into it, you can just use
:perldo s/\PSA{([^,]+),[^}]+}/$1/g

#configure CLion to build ivona-core
# Settings -> Build,... -> CMake -> CMake options:
-DCMAKE_TOOLCHAIN_FILE=config/toolchain-x86_64-pc-linux-gnu-ttsservice-alexa.cmake

Set any executable and run BuildAll once.

# run dump_ta from CLion
1) create build configuration
- copy existing ivona_dump_ta
- Programm arguments: --dnn-blob /home/local/ANT/didenkos/Projects/dnn/dnn_w2v.blob -C /home/local/ANT/didenkos/ivona/ivona-coreClion/engine/data/licenses/unlimited-1.5.txt -l ../../voices/libvoice_en_us_nina.so -x /home/local/ANT/didenkos/ivona/voxdb_archive -D ../../lexicons -i /home/local/ANT/didenkos/Projects/samples/Dnn1.txt --dump-diphones --dp-seq dnn_out.txt -w dnn_out.wav


- copy existing test_streamer
- Programm arguments: -v en_us_nina -a /home/local/ANT/didenkos/Projects/Google_word2vec_pruned.mpa -i /home/local/ANT/didenkos/Projects/samples/Dnn1.txt
- configure to run voice_en_us_nina in advance


# Get values of features for segments in text
./core/main/ivona_dumpfeats -relation Segment -feats "name nn.ph_cplace" "text"

# check/install perl libs if test failed
1) check which lib is missing
cd ivona-core/engine/testsuite/#
less *.stderr file
2) install perl lib, for example "Text::ASCIITable"
sudo cpanm Text::ASCIITable
3) run test for quick check
from ivona-core - engine/testsuite/TEST_NAME

#run tests
#from buuild folder
1) valgrind --smc-check=all ./engine/testsuite/unit/unit_tests
2) ctest -VV -R en-US # all test have "en-US" in the name
3) ctest -VV -R 'test_interpretation-en-US$' --debug

# list phoneme names in DB
less vox_en_us_nina_generic.chunks | grep speechcon | awk -F';' '{print $2}' | awk -F'=' '{print $2}' > phones_speechcons_.txt

# list phoneme names and file name
less vox_en_us_nina_generic.chunks | grep speechcon | awk -F';' '{print $2,$3}'

# build on Mac
1) fresh clone of ivona-core and ext on mac
2) did build all ext what was required
cd build
cmake ..
ccmake .
make -j8
