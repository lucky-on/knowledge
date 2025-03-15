# 1:1 with Fardad
- I think I know what is the root cause of the missalignmet between us
- The advices I'm getting from PEs and from career growth internal videos is - stick to what you do the best
- Let's try that

# 1:1 with Ehry (March 2nd 2021)
- Pryon Modularization
- Onboarding SID and Stutter should boost interest to Pryon-2


# 1:1 with Ehry and Fardad (Jan 2021)
- shared my concerns about Fardad's feedback

# 1:1 with Fardad (Jan 2021)
reasons for delays:
 - over indexing on high standards
 - growing scope of deliverables

# talk with
https://code.amazon.com/packages/PryonKeywordSpotterLite/logs
https://code.amazon.com/packages/PryonKeywordSpotterLite/trees/mainline/--/target/lib/tdsid

# 1:1 with Ehry
- Keep up with strategy for BlueBottle decoupling, focus on RNN-T ASR Stage 1 decoupling

# 22.04.20: Meeting with Stashek (first one to plan promotion)
- gap document (prepare for next meeting in two weeks)
    meeting criteria
    S: review and provide guidance on gaps
    working on doc, draft, comments,
    twice a month meetings with Staszek

Super important
- design docs
- impact on other teams

review code and design for others
- mentor
- interviewing
- tech talks

Proactively protect Amazon interests
   building software to easily port cloud components on device

Technical influence
  Inventions,
  you have to should that you are building,
  componatiozation,
  modularization,
  changing approach of development...

we have 8 years of history, we are building for next 5-10 years...

- Keep run visibility with PEs
- Set up reviews with WW and FP...

required for Senior Principals
- external talks and conferences

# LEX ASR, April 24, 2020
- chat bot platform, to serve customers, there are 2 types of customers: our (enterprise) and customer of customer (run-time customers)
    - build time phase: ASR part of it, they build bot models, use pryon_smc to build it, we load it with SLM we got from Alexa to built bot model
    - we use PryonJava to talk to runtime Pryon engine.
    - we feed audio to pryon engine.
    - we get bot model from MASS at run time
    - we support multiple languages (en,de,es...) and expanding
- we only see the result but we do not know what is happening under the hood, we want to udnerstand how does it work.
- scalability, how many modles we can load not to harm performance, we were not sure how that would effect our scaling performance.
- How would Pryon engine perform with multiple static models


# Alex Profiler Workshop
https://broadcast.amazon.com/live/alexaprofiler?eventId=13106

- profiler.amazon.com
 - reliability & resilience
   - obvious
    - Resource Exsostion
   - Not so obvious
    - inefficient error handling
    - constrained behavior
    - Increase time to recover
 - Efficiency vs Risk


# Michal

- AWS

- Using Arnold to build things, docker (but not for Mac OS or Ubuntu), but most production images use dockenazed approach, as wells as for release flavors
in total 19 flavors (release and debug), so about 10 different platform, and some are experimental
ARM Android
x86 Android
Memory consumption is a key thing
2-4 core platforms
  Fire OS: Sonar, Lidar, Bishop, Octave
  Fire TV: AHE Light,
  Generic devices for AutoMotive ARM, x86. For external party integration.

# Ehry 1:1
- cross team quarterly (every two month) meetings (I think "Pryon Sync ups" will work just fine if all key players attend)
- Red flags
- Help with Modularization (cross team work)
- Making modularization a bigger team goal (move under Ehry)

# 2018.10 - Trip to Seattle during CppCon2018

## Architecture (@Keith)
- How do we think the services (SpeakerID, Whisper, AED) ideally should look like?
- Do we want Combined ASR + SpeakerID service one day?
- We need to make sure that architectural decisions are discussed more broadly.
- @Keith provided draft design idea about new ASR service architecture
https://amazon.awsapps.com/workdocs/index.html#/document/76227443e756af347dfec8b80d4bd3514202fa7df62afe823bf568cbf840955f
&
https://drive.corp.amazon.com/documents/didenkos@/Design/ASR_Architecture_Vision_Draft_Keith.docx
- @Sergey shared doxygen-generated docs for Pryon package
https://drive.corp.amazon.com/documents/didenkos@/doxygen_pryon.tgz
- @Keith suggested to use PEs more intensively, involve them earlier to design discussions, iterate quicker.

## SpeakerID:
- EOU for SpeakerID, is it really required? What is the current status (there were results shown that degradation is less than 1% without EOU)?
- @Keith will address it to researchers as a follow up.

## Whisper:
- Is there collaboration between ASR and TTS? (@Keith will check it out with researchers).

## Modularization:
- ASR APIs
- Pryon common components / packages.
- New Config (more or less clear).

## PryonJava (@Keith, @Naresh)
- AED have their own PryonJava
- All other services (ASR, SpeakerID, Whisper) use current PryonJava.
- Each message - new connection
- pryond sends all TRACE logs all the time
- Functional:
  - More OO interfaces
  - Redundant struct dependencies
- Performance:
  - Threading model
  - Connection Model
  - Log contention (inefficiency), Java can send parameter "log level" and pryond filter out

Jackson serializer, use Reflection in config

## Prod-replay (@Andy Oberlin)
- Aniruddh Gupta (manager), Prashant Kumar (dev)
- Prod replay is doing snapshots every day for several hours
- They keep those snippets for some time (month or so), so you can reran test with absolutely same audio data if you know the ID of that set
- If you use the test set it will stay there for another 6 month

# BlueFST (Service to build Supplemental model)
- BlueFST do:
    - takes XML
    - use Pryon internally via PryonJava
    - parse XML
    - build FSTs
    - put them to tgz
    - sends them to ???
- as soon as I buy an audio book, notification is sent to LUX, then to SBB (Spectrum), then to SBM
- LUX stores what have to be rebuilt in JSON
- SBM:
    - takes JSON from LUX,
    - do tokenization (they are going to use BlueNativeToolkit)
    - put to grxml
    - sent to BlueFST
- AshService requests models and Spectrum provides the latest one
- AshService loads ALL models in memory on all hosts (start up time takes about 2 hours), team has a story to make it scalable in Q1 2018

---

## 2017.08.02 (Alexa Team Legal Training (US Teams))
- Legal Implications:
        - BEXTRA, valdecoxib tablets (story about 2.3 billion fine)
        - buzz, google, extra information was disclosed ($22 M fine)
    - Product Restrictions:
        - collecting information without written consent
        - privacy (building trust)
        - Promises & Expectations
    - Avoid sharing data
    - Biometric and Speaker Recognition
- Confidentiality and Data Security
    - Protecting Amazon CI (data, analysis, design)
        - Think about is Need an NDA?
    - Involve InfoSec
    - Examine and follow Open Source policy
- Communication
    - Documents
    - Social Media Policy
- Document retention
- Contracts
    - Never sign a third-party contracts
- Competition
    - Avoid Scrutiny
    - Avoid Penalties
    - Never discuss prices or services with competitors
    - Amazon build services & Products, nut platforms
    - Intelectual Property & External Data Access


## 2017.07.13 (1:1 with ASR team)
## Tiwari, Gautam <tgautam@amazon.com>

* How long have you been in your current role?  What did you do prior to this role?
    * 2,5 years, Bangalor office, SDE, payments systems.
* What tools do you use for s/w development activities?
    * Ubuntu, compile on Mac from home.
* What do you see as the 3 most important issues/projects that your department needs to address over the next 12 months?
    * recently moved to LSTM based networks
    * acoustic models go this direction, our implementation is crapy we want to make it 10x faster.
    * Single instruction multiply 4 integers.
    * BIGLM decoding, when decoding and very huge model, it will be slow or consume tons of memory (data duplications, )

* What are the biggest opportunities in my new role?
    * we are fortunate enough to work on this place, there are many small/big areas to improve

* Collaboration with other teams:
    * Research team: mostly with them
    * NLU: we provide lib BlueNativeToolKit (grammar matching) NLU is Java team.
    * Framework team: they use Pryon for FST building (write service to build them, used by personalization team, Seattle)
    * Device team: WW they use Pryon, they do some changes also to Pryon, for low power they make new code.
    * Builder team: Seattle, models building team. They use BlueFST, it uses Pryon.

## Challenner, Aaron <aaronlmc@amazon.com>
* What is your role?
    * Device team. we do two things:
        * WW and Finger-Priting
        * Pryon light (with guys in seattle) Gautam: “for low power they make new code."
* How long have you been in your current role? What did you do prior to this role?
    * 4 years, 1.5 y.a. team split, before Amazon several guys were in BBN defense, doing ASR-translation for military.

* What tools do you use for s/w development activities?
    * Eclipse, CLion, develop on Ubuntu, we use Container build.
    * For profiling Container build… more on that Shaun, Gautam can say

* What do you see as the 3 most important issues/projects that your department needs to address over the next 12 months?
    * WW (Dopler, Pancase, Buiskit, Hendrics, Knight, Radar, Sona (Dopler V2), Stark, Rook, Tablets)
    * Fingerprinting (Static, Dynamic)
    * Scaling-automation (Australia, Canada), FRITES (France Italy Spain)

* What do you see as the biggest challenges/issues I will face in my new role?
    * Getting up to speed with information

* How does my role impact you (and your team)?
    * We share a lot of DNN code. LSTM Component encoding.

* What advice can you give to me to get up and running at Amazon as quickly as possible?
    * Find some small project from end to end.

* Collaboration with other teams:
    * WW Researchers (17th floor, under Rohit)
    * Device tem in Sunnyvale
    * ASR cloud team (Seattle) Suraj. Mostly about Fingerprinting


## Seibert, Lucas <seibertl@amazon.com>

* What tools do you use for s/w development activities?
    * Emacs, Eclipse, VD for Brazil dev needs.
    * LCOV, builds on top of gcov.
    * GPROF
* What do you see as the 3 most important issues/projects that your department needs to address over the next 12 months?
    * Solid foundation of develop/testing (tools to build and profile on ToD)
    * Raise quality bar, consistency, docs, get up to speed quickly
    * Testing, coverage. Getting performance metrics in no-touch way. Stability.

* What do you see as the biggest challenges/issues I will face in my new role?
    * We have many customers who do requests, and not very clear picture of priority (death by 100 cuts)
        * NLU team,
        * BNTK tool,
        * Communication team (add features to allow to build communication features), 500k catalog team (enable skiils to use large catalog, currently there is limitation in size ~under 100k,  ),
        * Modeling team (often experimental, dynamic interpolation, in utterance adaptation)
        * Research team.
    * We are growing very quickly:
        * culture aspect
        * making right decisions
    * Figuring out what to be Voice platform
        * which skills we support, how many
        * scale of languages, regions, locales
        * There is no principal who is looking to that from architectural point of view
* What are the biggest opportunities in my new role?
    * hard part for me, to consider, how do advertise and make sure you are working on hight impact part.
* How does my role impact you (and your team)?
    * SDM absent, build culture, working on right things...
* What advice can you give to me to get up and running at our team as quickly as possible?
    * Sitting on code review, be second engineer in initiative. Work with Gautam.
    * Make sure to set up expectations with STO


## MacRostie, Ehry <ehry@amazon.com>

* How is your team structured? (if applicable)
                 Device                        Cloud
    * Device (WW, LPW) |  Framework, Algorithms
    * (YAP, IVONA) startup name acquired by Amazon about same time.
    * 1.5 y.a. acquired BlueFST service.
    * This year rolling out more services:
        * BlueTok (tokenization, formatting) in Prod by mid of Aug,
        * BlueNativeToolKit (C++)
        * Speaker ID (code base in Pryon), delivered for GA (General Availability), Proactive Speaker discovery (September +)
* What do you see as the 3 most important issues/projects that your department needs to address over the next 12 months
    * Language expansion, 50 languages by 2020
    * Scaling dynamic models (about 4 MB, grammars fro Alexa skills, about 70000 of them)
    * Internalization challenge: how to quickly update models.
    * reduce Service start up time, background computation
    * Speaker ID.. interesting and new area

* What do you see as the biggest challenges/issues I will face in my new role?
    * ramping up with ASR
    * threading in Pryon if fragile
    * do a little survey in different areas: end-pointing (Kyle), Decoder FST (Shaun),

* What advice can you give to me to get up and running at Amazon as quickly as possible?
    * focus on threaded models, performance (16 decoders by 5 threads + 100 thread for Java)

## Pareek, Sonal <spareek@amazon.com>
* What is your role?
    * SDE2, Supplemental building service, GRXML, stateless service, OOV words (Out Of Vocabulary)
    * Splitting huge Pryon into multiple libs - dropped
    * BlueNativeToolkit (Gautam mostly)
* How long have you been in your current role?
    * 4.5 y.
    * Shaun knows a lot about supplemental models build.
    * Plan to make them smaller (on the fly reconciliation, Shaun is working on)

## Goehner, Kyle <kgoehner@amazon.com>
* What is your role in a team?
    * 2 y, BlueFSt, deployment process, focused on building out how do we start managing the number of alarms Richard is building dashboard, monitor automation.
    * Shadow fleet (run new models before Prod, how they perform again prod traffic, performance tests )
        * status: depends on code review from Cloud team (Seattle) - management issues
        * Scale:
            * Echo fleet, 1000 hosts for Echo trafic in US,
            * there are other fleets for another type of devices
    * End pointing: process to determine when user stopped speaking (utterance detection)
        * easy with the button hold until you speak
        * more complicated to determine when person stopped talking
        * researchers are working on personalization of end-pointing
* What tools do you use for s/w development activities?
    * ninja_dev_sync
* What do you see as the biggest challenges/issues I will face in my new role?
    * Scaling regions, devices, all this requires new alarms, monitors
* How does my role impact you (and your team)?
    * threading model needs improvements
    * payload, pipes filters, thread boundaries
    * we also pass messages through events, double dispatch mechanism

## Stavrev, George <stavrev@amazon.com>
* What is your role?
    * WW (low power WW, Full size Pryon WW,, super Low Power),
    * Automation: models about WW, run CPU test with small audio test, document results on wiki, send to device team.. byt the end if the year, now about 8 models per week to test.
    * KATS (device automation testing)
    * Fingerprinting: Statis, Dynamic. There are 2000 static fingerprints

## Moore, John <moorejh@amazon.com>
* What is your role?
* Main project - Speaker ID,
* How long have you been in your current role? What did you do prior to this role?
10 month, Boing, Military company
* What do you see as the 3 most important issues/projects that your department needs to address over the next 12 months?
    * Service, SpeakerID, Tokenization
* How do you think I can make the biggest impact in the short term? Long term?
    * Study domain area.
https://www.amazon.com/Statistical-Methods-Recognition-Language-Communication/dp/0262100665/ref=sr_1_1?ie=UTF8&qid=1500329631&sr=8-1&keywords=statistical+speech+recognition
More about ASR but not DNNs
https://www.amazon.com/Automatic-Speech-Recognition-Communication-Technology/dp/1447157788/ref=sr_1_1?s=books&ie=UTF8&qid=1500329673&sr=1-1&keywords=automatic+speech+recognition
Very good about DNNs

## Sivan, Yuval <yuvalsiv@amazon.com
https://bluespeechportal.corp.amazon.com/model-dashboard/index.html
dopler-scone: AVS use, Alexa Remote control (hold to talk)
project-fox-auto-ep: Amazon Tap (mid field)
projectd-ff: far field models


## 2017.07.10 (HR)
Alexa (many floors)/AWS (only 18 floor) - 50/50
5 - Audible
6,7,11,17 - Alexa
Medical plan change window (Feb-March)

## 2017.07.03 (Holly Ellis) - first baby-steps in US
- stoks
- benefits.amazon.com
- temporary housing address vs permanent
- https://peopleportal.hr.corp.amazon.com
- payments/deductions

## 2017.06.28 (Rafal)
Super Powers:
- bias for action
- deliver results
Growth opportunities:
- attention to details
- high level vision

## 2017.06.21 (Marek)
Short term
* Address the comments
* Try same sample rate for voice and polyphones (without resampling)
* Fix the whispering issue (discuss with Alexis)
Mid term:
* Add PolyphoneDB generator to Tools
* Update wiki how to generate PolyphoneDB (https://wiki.labcollab.net/confluence/display/TTS/HowTo+generate+MPA)
* Make new solution work with PolyphoneDB as MPAs
    * Need to agree on SSML tagging
        * either “Wow_1” or “Wow_low” or “Wow” + one more parameter
        * discuss with TTS-Framework team (Tomasz Blukis, Remus, Marko)
        * they will have to update documentation accordingly
    * Build PolyphoneDBs for each voice
    * Make sure QA update their tests
* Discuss with Audio/RVD to define WHEN, HOW exactly they integrate thy switch to building PolyphoneDBs separately from Voices
* Push new solution to Prod
    * V1
        * Update ivona.addon with PolyphoneDBs for all voices which use it.
    * Long term - Final goal (once TTS Data Continuous Deployment will be in place)
        * Use separate Brazil package to put new version of MPA with PolyphoneDB.
        * Make RVD team to build and update these MPAs.
* Once new solution work in Prod
* Let RVD team know that they can to get rid of Speechcons from the voices (Nina, Aby, Silke ...)

## 2017.02.27 (Rafal & Federico)
- schedule 1:1 with Parind to define start date
- Doc, plan to finish with Andrzej’s work
- Help to Mateusz J. with his ideas (long term planning)

## 2017.02.20 (Rafal & Federico)
- Prepare Docs
- Schedule 1:1 with seniors from Parind’s team.
- - Long term vision of MPA in doc.
- Go through TPR meeting to review the doc for MPA, Dynamic VoxDB etc.

## 2016.12.08 (Jacek, Tomasz N), merry MPA with TTS Service
- branching, versioning of the Brazil packages
- think about SynthService, RVD (SynthService runs on Prod fabric, while Brazil is on Corp)
- need to sync up with Lang Dev team

## 2016.11.22 (Adam, Slava)
- Do not insert pauses for the prompts like jokes, speechcons
- Do not train DNN and alignment models on them

## 2016.11.16 (Toomek H, Michal K)
Repos:
gerrit-blizzard - blizzard (machine of Michal Czuczman)
gerrit-aka - PDBS (machine of Michal K )
gerrit6 - located in Sunnyvale

1. IVONA Continues integration is about:
    1. Project: Separate data from SDK.
    2. Project: Blizzard and PDBS eradication.
2. Identify dependancies for building in PDBS (@Michal K // 11.18) + create additional stories & update wiki “https://wiki.labcollab.net/confluence/display/TTS/Blizzard+Eradication+Project”
3. Tomek: Follow up about "Automate change log creation"
4. Tomek: Check do we have ACC machine available?
5. Tomek: Check how much time it takes to get new ACC machine?
6. Sergey: Try to fit “Move Blizzard Master to ACC” to next sprint (master + one slave)
7. Michal: Work on PoC of rewriting ivona_core history
8. Tomek: investigate how to store Jenkins config files (to mitigate restarts)

## 2016.11.16 (Staszek P)
1) Status of “polyphone” like requests. Decide about next steps of “Polyphone DB” project.
* the plan is that there will be separate storage for the prompts to play back (songs, jokes, etc).
* Most likely once that is done we will need to get rid of jokes from TTS Engine and voices.

2) There are several ideas of the project to focus on, but need to sync up with you, what do you think about it.
* voice and binary release independently.
* keep in mind 64bit addressing

3) Techtalk about TTS-MPA (Multi-Purpose Addon), discuss best time and content.
* Dec 16 + show long term design view.

## 2016.11.14 (Adam N)
* Discussed about needs for Dynamic VoxDB section project
* Voice building process

## 2016.11.13 (Bart)
* Discussed about needs for Dynamic VoxDB section project and alternatives.

## 25.02.2016 - SSML Meeting
* Is this document http://developer.ivona.com/en/ttsresources/ssml/ssml.html up to date?
* Which SSML specification do we support? 1.1 or 1.1 extended?
* Does SDK provide the XML Schema that defines the supported SSML?
* What should we do in-case we wouldn’t like to support a given SSML element? Is there a way to set SDK to ignore a given element / attribute? If not, do you think it is doable?
* How to do a voice name mapping - ex. en-US/Salli -> en_us_salli? Should we do that in SSML?
* How SSML input is being mapped to SpeechMarks? Can we easily change the customer request before passing is to the SDK?
* What are the supported features that are out of the scope of SSML standard? ex. Domains.
