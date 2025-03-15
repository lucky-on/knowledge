## Email about Stutter engine

"Re: Review AL tech requirements"

MFCC features are not supported out of the box in the current implementation of the PryonPipeAudioToFeaturesLib engine, but if I see it right is a matter of more or less simple conversion.

If you ask me about what it really means, I can tell that from here, there are multiple ways of during it :
1.	Add that support (port that code from Pryon) to existing PryonNodeFeatureExtractor and control what features to emit via config.
a.	That way all other engines that are using this Node will be able to start using MFCC features
b.	But if single engine needs both FLBE and MFCC there will be more logic involved and maybe double compute, and dependency on the code which you do not use for those who do not need MFCC features
So preferable way, as I can see it, would be: 
2.	develop tiny Node, say PryonNodeLFBEtoMFCC (port that code from Pryon) and add it in the chain of data processing pipeline of the Engine.
