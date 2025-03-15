1. validateProfiles
2. can we emit multiple times, in what order?
3. what about push

4. walk through logic in pushEndOfUtterance
5. pushSessionEnd, what for?

6. initializeResult, upfront?

C++ exception with description "Data (samplerate) is not present [/local/home/didenkos/sid/src/PryonConfig/src/api/pryonconfig/common/config_object.cc:139]" thrown in the test body.

system_PipeTest.PushAllTI_ReceiveSpeakerIdResultCallback
send stream index: ub.end = 2147483647 audio_samples_so_far_ 83840

- stream index

- add packages to arnold VS
https://wiki.labcollab.net/confluence/display/SHELBY/Adding+a+New+Package+to+the+AlexaHybridEngine+Version+Set          

ah_build branch should be empty until Prod ready, can work locallly

- Locally build is just part of the image

Flush with base image form KBITs (from release run book page),
 - https://wiki.labcollab.net/confluence/pages/viewpage.action?pageId=1212853926#ASREngineBluebottleReleasesRunbook-Setupandruntheon-devicesanitytest


Target AlexaHybridDistribution package (add to WS)

Once I have dependencies set up I would do something like this
- arnold ws add --from-package PryonPipeAudioToSpeakerId
 // - arnold ws add --to-package PryonPipeAudioToSpeakerId

- arnold ws build --all


SSO hardcodded config, we do nto know what faield when customer cannot singn in, identity server is done,
doctors, at the hospitals, (midway authentication), use 3rd party, use evisit with no password, when new user shows up new
