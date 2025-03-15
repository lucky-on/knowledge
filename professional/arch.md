Tenets
- Architecture is about intent. The architecture of code/components/packages should clearly express its intent.
- Coupling is not a bad thing, this is what make a System, but ACCIDENTAL coupling is bad!

- A good architecture allows major decisions to be deferred. A good architect maximizes the number of decisions not made. ((https://www.youtube.com/watch?v=Nsjsiz2A9mg))
- SOLID
  - The Single Responsibility principle
  - The Open-Closed principle
  - The Liskov Substitution principle
  - The Interface Segregation principle:
  - The Dependency Inversion principle: High level concepts are independent and Low level concepts depend on High level concepts.

- TDD, CDD, PDD
- The Tuckman cycle (Forming, Storming, Norming, Performing)
- Maslow hierarchy of need
- Empowerment
- Certification

- Add global_data_ to PipeBuilder and Pipe

Coupling is not a bad thing, this is what make a System, but ACCIDENTAL coupling is bad! (https://www.youtube.com/watch?v=gPP7Bleg214)

More you learn - less you know - keep learn more and become an expert (The Dunning-Kruger Effect)

Illusion of explanatory depth

It is hard to get full list of requirements for each customer, so we need to come up with architecture
which, with incremental changes can evolve to satisfy old and new customers naturally.

https://medium.com/@jesse_watson/the-hard-thing-about-software-development-4c9a4f7e1d42
(Jesse Watson - https://phonetool.amazon.com/users/jlw)
“The most valuable asset in the software industry is the synthesis of programming skill and deep context in the business problem domain, in one skull.”

Tasks:
- Generate complete list of Pryon customers
  - Draw Brazil packages dependency graph.
    - Pryon
    - PryonJava
  - Draw Brazil VS-Pryon-consumers graph.
    - Pryon

  - Clarify requirements for each customer.
  - decouple all you can
  - modularize
  - You cannot do much on PryonSwarm if borders of modules are not clear
  - Identify big components (front-end, back-end, etc)
  - setup templates
  - setUp rules and best practices to follow

Decoupling (Brazil-packages)
- to decouple grxml2fst converter
- to decouple SMC
- to decouple MetadataBlob serializer / deserializer

Modularization (decompose Pryon to independent modules)
- Blocked until new Config system is ready to use
- Pryon API
- Pipeline builder module
- ASR Front-end
- ASR backend
- Logging subsystem
- Metrics subsystem

OO approach vs Long Data oriented design
- series of deep dive to:
  - data flow in the Pipeline
  - algorithmic part of engine
  - data structures used, and search the way to optimize
