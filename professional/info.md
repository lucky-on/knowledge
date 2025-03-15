ASR to read:

https://www.amazon.com/Statistical-Methods-Recognition-Language-Communication/dp/0262100665/ref=sr_1_1?ie=UTF8&qid=1500329631&sr=8-1&keywords=statistical+speech+recognition
More about ASR but not DNNs

https://www.amazon.com/Automatic-Speech-Recognition-Communication-Technology/dp/1447157788/ref=sr_1_1?s=books&ie=UTF8&qid=1500329673&sr=1-1&keywords=automatic+speech+recognition
Very good about DNNs

1. Data for latency thresholds
    1. https://wiki.labcollab.net/confluence/display/Doppler/ASR+Model+Deployment+Promotion+Criteria
    2. https://bluespeechportal.corp.amazon.com/model-dashboard/index.html#/model/AshService/NA/projectd-ff
    3. https://pac-explorer.corp.amazon.com/queries/17744
    4. https://bluespeechportal.corp.amazon.com/model-benchmarking/index.html#/compare-jobs/job1/5080470f-9813-4faa-b983-ff7704c2bd40-prod-usamazon-08222017/job2/50ffbba5-67c7-41b5-9f03-b19cdeb467c5-prod-usamazon-08222017

Notes:

1. Thread Sanitizer
2. Clang format
3. clang tidy sanitizer
4. parser c++
5. address sanitizer
6. profiler tool от Якова

Threading AshService, IO, message handlers

non blocking IO
when request comes one pool of thread address network pipes coming
multiple threads can handle data coming from simple connection
every single p of data

data comes to single thread, we create user thread pool to fetch models from spectrum 4-5 thread (prefetching), while thread is waiting decoder to complete pryond also calls back to AshService, we feed those models to the pryon,

create decoder can takes 200-300
meanwhile multiple threads are buffering audio until we get decoder complete complete

SOS SOU, EOU, EOS…and so on each of these call backs 

PryonJava - PryonD - Shaun did something there

There is a single daemon

for each request 100s of messages sent between PryonJ and PryonD

if JVM starts on INFO and PryonD Lower - all messages are sent from PryonD to PryonJ and dropped there

Number of debug logs (one thing to check)

New connection is establed for each message, instead of keep connection 

Looks at PryonJ protocol buffer implementation

AshService”
* threadpool to save data to DataMart 
* threadpool to fetch models from Spectrum
* per stream and per utt metadatata
* per utt metadata
* pryond metadata

they want to replace the protocol with what BlueFront is using
