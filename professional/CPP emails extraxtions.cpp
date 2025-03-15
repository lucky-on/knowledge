P emails extraxtions

===|||===

BRAZIL_PLATFORM_OVERRIDE is no longer the way to work with RHEL5_64 version sets on AL2012. “brazil ws use --platform RHEL5_64” is.



===|||=== tool to profile memory during compiling time

templight [ https://github.com/mikael-s-persson/templight ]

It’s a great tool but it’s pretty hard to use in my experience. I got it to work like once or twice and that’s it. Unless they changed it, you have to compile your own clang with their patch and it’s a pain. But if you get it to work, you may get some nice insights.
If you’re mostly looking to benchmark metaprogramming code, you should look into http://metaben.ch. It’s a simple CMake library that makes it easy to setup compile-time micro benchmarks. It supports compilation time and link time, but also memory usage and other metrics (e.g. code size if I remember correctly).

I have used it and it is useful if you are doing some heavy template metaprogramming, or preparing some presentations and want to show how stuff gets instantiated. Otherwise probably not worth the hassle.



===|||=== determine the compiler version a package was built with

The name of the branch of CFlags that is in your version set will tell you which CFlags implementation is being used. If you never changed anything, it’s CFlagsLive, which delegates to CFlagsNative on RHEL5/RHEL5_64 (GCC 4.1 or 4.4, I forget but it’s the system installed one), and to CFlagsGCC-4.9.x on AL2012.

You select a compiler toolchain per-versionset. For a package’s artifacts to be reused, its entire dependency graph has to be identical (in structure and in commit ids).

Relevant: https://w.amazon.com/index.php/AlternateCCompiler

There’s also querying the object files:
https://stackoverflow.com/questions/2387040/how-to-retrieve-the-gcc-version-used-to-compile-a-given-elf-executable
And just running `flags` in your versionset to see what it has:
$($(brazil-bootstrap -p CFlags-1.0)/bin/cflags CC) —version

If your cloud desktop is using GCC 4.4.6, that makes me think you are running with Brazil CLI 1.0, or you have BRAZIL_PLATFORM_OVERRIDE set (it seems to still be getting set by default on cloud desktops) to RHEL5_64. If you were properly using the AL2012 platform, you should be getting GCC 4.9.4.
I suggest fixing this, because building C/C++ apps on AL2012 using RHEL5_64 artifacts causes non-obvious problems.



===|||=== ./configure not finding GLib during dryrun

I’m trying to build a third party package (that I’m trying to import).
When ./configure runs, it doesn’t find Glib, even though I clearly have it in my config file, I put
Glib = 2.40.x;
in both the build tools and compile dependencies to cover all bases (and built it into my version set), but still configure cannot find it, any idea what could be wrong ?
 
As I recall, Glib (and Gstreamer) put their includes under include/<project>-<version>/, and expect that to be on the include path (e.g. dependent packages #include “foo.h”, not “glib-2.0/foo.h”).
There isn’t really a way to model this in brazil such that consuming packages “just work”.

To be more specific, the typical third party package makes a libfarm, and then adds -I$libfarm/include, you also need to add $libfarm/include/glib-2.0 in this case

How did you import it? Via brazil-third-party-tool?
If so, then the custom-build script gets generated for you. The custom build script will include both:
https://code.amazon.com/packages/Libnice/blobs/8b96bee91a0f6e97f8cccc14108864775b8e2874/--/build-tools/bin/custom-build#L35
https://code.amazon.com/packages/Libnice/blobs/8b96bee91a0f6e97f8cccc14108864775b8e2874/--/build-tools/bin/custom-build#L40

What are you importing?
If it uses pkg-config, you’ll also need to add a build-tool dependency
Pkg-config = 0.29
for that and add
export PKG_CONFIG_LIBDIR="$libfarm/lib/pkgconfig"
in your custom-build

I am importing Wireshark 2.4.3 as I’m working on a project that leverages its lib + some modification to its code (got OSS approval already, and the code builds on Ubuntu).
I am now seeing something else, and it’s different between AL and RHEL in surprising ways.
On AL2012 their autogen.sh script looks for python and fails because it cannot find it, on RHEL build fails because it cannot find the hashlib python module. 
Isn’t python a default on all systems ? The package builds on my DevDesktop, it only fails during a dryrun so clearly it must be picking up my local files instead of what’s in the build environment.

With AL2012, very little is installed by default. Notable things removed versus RHEL5 are python, Make, and gcc.
You’ll need to add a Python interpreter dependency as well as whatever package provides the hashlib module. Then you’ll have to make sure that configure script discovers that python. Then you’ll have to make sure any resulting scripts (e.g. in build/bin/) have the correct shebang lines so when deployed it uses the right python.
BTW “the code builds on Ubuntu” counts for exactly 0. Ubuntu is not a supported brazil development platform :)
I am only partially triggered by the mention of Ubuntu due to how many times I have to bail out teams that make completion claims based on stuff they built on Ubuntu (so not at all deployable).

I'd suspect you'd need a different Python dependency (instead of CPython), and you may need to Brazil-package Python-Hashlib.
My preferred debugging mode for this kind of problem is doing chrooted builds on my dev desktop.

So shall I take it that many OSS projects end up being modified to build in Brazil ? I thought most were kept as-is and the build env was modeled around them

Not that many are modified. Mostly modifications related to dependencies being at a different place at runtime, runtime path not being known, etc. For example, shebangs for python are unavoidable because there’s no way you’re going to inject enough environment variables or command line options to make it emit scripts with “#!/apollo/sbin/envroot $ENVROOT/bin/python2.7”. Also, executable binaries often need to be wrapped in a script (see DynamicLaunchWrapper) to set their LD_LIBRARY_PATH correctly since they can’t just assume everything is in /lib, /lib64, /usr/lib, /usr/lib64, etc.
Of course some packages present a challenge and require a lot of work to fully brazilify, but at least in my experience it’s not many.

Interesting, how do you chroot your environment ?
Also, I’m seeing packages that clearly make use of hashlib (https://code.amazon.com/packages/RackLocator/trees/mainline for example) so somehow this must be present, somewhere, in some package. I just don’t know how to find what package to include…

https://w.amazon.com/index.php/Desktop_Sandboxed_Builds documents the CHROOT approach.
Searching for python-hashlib seems to mainly yield yum-based configurations: https://code.amazon.com/search?term=python-Hashlib

I’ve been able to almost entirely eliminate builds-for-me-but-not-in-the-fleet cases by just controlling my PATH. My ‘bb’ replaces the PATH with what’s on the build (AL2012) fleet before invoking brazil-build. Here’s the details: https://w.amazon.com/bin/view/Wash/AL2012BuildPath/

That’s pretty cool, makes it a lot easier than spawning dryrun builds repeatedly, thanks !



===|||=== Enabling brazil-build test with a custom build

Is the brazil-build operation (release/test…) exposed somehow into the custom-build script so I can check its value ?
Is there any way I can expose code coverage metrics from the test run ? (drop a coverage file somewhere specific maybe ?)

The arguments you pass to brazil-build are just forwarded to the declared build-tool, in this case your custom-build script.

This seems to have some answers for doing code coverage in c++, warning, I haven't tried to follow the instructions: https://sage.amazon.com/posts/93682
Here's a trivial custom build that has a "test" and "release" target: https://code.amazon.com/packages/MoBash/blobs/MoBash-1.0/--/build-tools/bin/custom-build



===|||=== C++ Recurring Bug: boost::mutex::scoped_lock(m_mutex)

Hi C++ Coder,
 
I created one issue https://issues.amazon.com/issues/AURORA-5495 about one recurring bug discussed in the following video.
  CppCon 2017: Louis Brandy “Curiously Recurring C++ Bugs at Facebook”
https://www.youtube.com/watch?v=lkgszkPnV8g  (You are welcome to watch it if you did not see it before.)
 
boost::mutex::scoped_lock(m_mutex);  is a typo bug (why? See example attached).  Compiler does not catch it.  
 
You may need do the same code search on your C++ code to check if your source code package has the same bug.
https://code.amazon.com/search?term=boost%3A%3Amutex%3A%3Ascoped_lock%28
 
Sheng-Liang Song
 
Here is the example bug code (with gdb disassemble info attached).
 
typedef boost::mutex mutex_t;
typedef boost::mutex::scoped_lock scoped_lock_t;
 
class AInt {
   int m_i;
   mutex_t m_mutex;
public:
   AInt() : m_i(0), m_mutex() { }
 
   void bug1_inc() {
      scoped_lock_t(this->m_mutex);
      ++m_i;
   }
   void bug2_inc() {
      scoped_lock_t(m_mutex);
      ++m_i;
   }
   void ok_inc() {
      scoped_lock_t lock(m_mutex);
      ++m_i;
      std::cout << std::this_thread::get_id() << ": " << m_i << '\n';
   }
   AInt& operator++() {
      bug1_inc();
      bug2_inc();
      ok_inc();
      return *this;
   }
   AInt& operator--() {
        scoped_lock_t lock(this->m_mutex);
        -m_i;
        return *this;
   }
   int get() const { return m_i; }
   // friend std::ostream& operator<<(std::ostream& out, const AInt& a);
};
 
https://github.com/Shengliang/language/blob/master/c%2B%2B/boost_example/ex2.cpp
https://github.com/Shengliang/language/blob/master/c%2B%2B/boost_example/ex2.gdb.txt
 


===|||=== Gcc 4.9 on Amazon Linux




===|||=== C++ unit test framework recommendations?

Boost unit test framework. No complaints at all. It integrates seamlessly with CMake, and you’ll find lots of support internally and externally.

Googletest: https://github.com/google/googletest
It just works, and it has useful macros (like "close enough" equality for floats).
Available in Brazil as:
https://code.amazon.com/packages/Googletest/trees/mainline

My team is using googletest with companion of googlemock which is very mature library. It’s widely used also in big open source projects (i.e. Chromium). Testing API seems to cover all possible use cases that can be also easily extended, and with gmock companion, besides mocking, brings you even more checkers such as comparing containers etc. If you’re planning to use gtest with cmake then it integrates nicely with their test runner - ctest (see https://cmake.org/cmake/help/git-stage/module/GoogleTest.html).
If you’re boost fan you might find boost.unit_test useful. AFAIR compile times were faster with gtest (I might have old info so YMMV)
I’ve also had some experience with other popular libraries like Catch which is kind of nice – very modern design and all you need is just to drop catch.hpp in your project to start unit testing.
Anyway, gtest is still my favourite.

We’re using googletest as well and are happy. Integration with CMake works as well.  In a previous project I particularly liked the possibility of parametrized tests:
https://github.com/google/googletest/blob/master/googletest/docs/AdvancedGuide.md#value-parameterized-tests

Our team is also using gtest/gmock. If you are using CMake, you can set it up to auto-run during builds. It has been pretty useful.

We are using Catch: https://github.com/catchorg/Catch2
Very nice, BDD-like:
https://github.com/catchorg/Catch2/blob/master/docs/tutorial.md#top



===|||=== Internal compiler error while building with GCC-7.x

We are trying to build a third-party library that depends on some C++ 17 features. The library builds fine on the build-farm but gives “internal compiler error: Illegal instruction” message while building on the personal cloud desktop.

Are you compiling assuming a specific architecture (e.g. -march=haswell) because the compiler will insert SIMD instructions accordingly for best performance at higher optimization levels. These instructions might be supported on your build host’s processor, but not your personal computer. A good example here is assuming avx2 during compilation as v4 will have avx2 and the v2 won’t. If you send your compiler options for the code in question, then we’d be able to say with more certainty what the instructions are. But it looks like an avx2 issue to me.

The compiler we are using is GCC-7.x from Brazil (https://code.amazon.com/packages/GCC/trees/GCC-7.x/--/), as built by Package Builder. It seems to attempt to build with "-march=core2", but perhaps that isn’t applied universally?

I think this is a problem in CFlagsGCC, and it appears to be all-versions (4.9.x, 6.x, 7.x)
Follow things here:
https://issues.amazon.com/CFLAGS-42



===|||=== Server framework with client

I am looking for a server framework for C++ that would have the following features:
Multi-threaded
Supports a binary protocol
Provide generated client code to call the server’s API
Client would maintain a pool of persistent connections to the server (something similar to Coral clients)

Take a look at GRPC:  https://grpc.io/
It has all the features you describe and also supports cross-language (cpp, java, python, ruby, etc.) communication out-of-box.

Nginx has decent support for this via modules. 
On the client front, if you have a coral model (you need not have an actual coral service to have a model) or just a c2j file, You can generate an SDK to hit any service you want over http in any of our supported languages for the AWS SDKs.

Boost asio library has fantastic concurrency support.
It gives you basic TCP connection, but you can build on top of it. Some good examples are here:
http://www.boost.org/doc/libs/1_55_0/doc/html/boost_asio/examples/cpp11_examples.html

Kenton Varda’s successor to protobuf, capnproto, has a built-in RPC protocol:
https://capnproto.org/ 
I haven’t used it personally, but if you’re interested in rolling your own framework, that would get you 2/3rds of the way there.  For my last project, we used a custom RPC implementation with Flatbuffers for serialization (http://google.github.io/flatbuffers/).

It looks like what you need is JAWS web-server from Vanderbilt (based on ACE C++ framework from the same group).  Or you should check ACE/TAO if you want to build your own.
http://www.dre.vanderbilt.edu/JAWS/
Here are the links for Douglas Schmidt’s presentation:
https://www.youtube.com/watch?v=2BP0277KeHg
https://www.youtube.com/watch?v=AhCkTazFT7s

POCO
https://github.com/pocoproject/poco
If you need a HTTP-based protocol (including websocket), boost beast is a good choice.
https://github.com/boostorg/beast

Back when I was in monitoring we used POCO HTTP server in a time series datastore we developed. No complaints. All the data you see in PMET of the 3 most recent hours, comes from that service. The server code is minimal, and we were able to achieve 30K TPS per host (during tests):
https://code.amazon.com/packages/GoldfishAggregatingDataStore/trees/mainline
I’ve used Capnproto in the SPICE engine part of Quicksight. It bloats your data, but gets the job done, and you get Java/C++ clients almost for free.

I have seen CapnProto, Protobufs and Thrift being used inside amazon. 
CapnProto: Spex used a server for serialization and communication
Thrift: AWSRekonitionProcessingService, Thrift used to create a HTTP Server that is used to communicate with the cora service RekonitionService
Protobuf: CairoEngineProtocol used to serialize data between a cpp binary and java coral service.

AWSRekonitionProcessingService is a Thrift service over TCP. It’s not a HTTP service. 
Thanks for mentioning it though. 
Regarding other criterial, it’s multi threaded, support binary protocol over TCP. It generates a client, but I don’t think it provide connection pooling.



===|||=== Building C++ package on ubuntu and mac

I want to enable building a C++ package onto ubuntu and mac for development purposes by utilize existing brazil-build system in place. Since current BrazilCLI doesn't support this, I wanted to know if anyone has already solved this problem.
I came across the ContainerBuild build tool which creates a docker image which I feel can be a possible solution, but before I try that, wanted to get some feedback from you guys.

A quick correction :) The BrazilCLI does support building on OSX (it supports Ubuntu, RHEL6_64, AL2012, and OSX).
https://w.amazon.com/index.php/BrazilCLI_2.0
What's failing on OSX is the Brazil build-system being used (are you using BrazilMake or similar?) because it's picking up some system libraries.
Yes, ContainerBuild will solve this for you be performing the build inside a Docker image, providing a consistent build environment. But then you run into the same issue - you're picking up the system libraries inside the Docker image, and if you try to use that application or library outside the Docker image it may fail.
ContainerBuild also supports creating a Docker image to *run* your code, but now you're moving to using Docker for runtime, deploying it, etc. 
What are your consumers expecting? What is your code's portability requirement?
Are you just trying to build on OSX for development convenience, or do you need to support OSX as a target platform?

Minor correction from my previous email: BrazilCLI_2.0 do not support building C++ code on mac and ubuntu, since cached dependencies are build for RHEL/AL2012 and are not compatible with ubuntu and mac when these libraries are linked.
I'm mostly interested in enabling the build on Ubuntu and Mac for development purposes only and not for deploying to production. Since most of our users are ML scientists and many of them don't have cloud desktops! (plus they *really* prefer ubuntu!).
We do have a sparate build script which compiles all the dependencies from scratch and then compiles our C++ package. However, this approach is quite difficult to maintain and hence I'm looking into alternative options where I can leverage most of the benefits of brazil.

have you tried to use NowYouCmake (https://w.amazon.com/index.php/BrazilBuildSystem/NowYouCMake)? You can build packages on ubuntu and amazon linux with it.

You should definitely take a look at ContainerBuild then - it integrates Docker with Brazil:
https://w.amazon.com/index.php/ContainerBuild
It's a bit of effort to get setup, but in the end you will be able to transparently build on any platform that supports Docker.












