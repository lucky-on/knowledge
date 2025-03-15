2017.04.14, Webinar: Design, how do and review

- Consultations, Shallow or Broad Review
- Deep reviews

Overview
Terminology
Tenets
Current Architecture Proc and Cons
Proposed Architecture Proc and Cons
Detailed Design of components
Appendix 1: PR/FAQ and requirements
Appendix 2: Alternatives
Appendix 3: Diagrams

What do you look for in a design
- Problem statement, is it right problem we want to solve?
- Do not build platform for rest of the company when there is no need
- Tenets
- Alternatives
- Paradox of Choice (Bias for action and )
- If there is choice between A and B, step back, think how do I design so that choice between A and B is less significant?
- Design should be as simple as possible, as complex as necessary.
- How do you know if design is complex or simple
    - Modularity
    - Reuse, Easy maintenance
    - Flexibility
    - Identify where flexibility is warranted, in order to avoid unnecessary complexity
- Engineering pattern
    - Address recurring problem
    - Describe generic solution that worked
    - Description of successful engineering stories
    - Patterns give a common vocabulary
    - Applying pattern is not never mechanical
        - Does design fit an engineering pattern?
- Scalability
    - What read/write needs to be supported
    - How big will the corpus grow
- Interfaces and Abstractions
    - Inputs and Outputs for each component
    - Are the API’s bounded?
- Data model
    - What?
    - Who is the owner
    - Can we reuse existing instead of inventing new types?
    - Consistency guarantees that needs to be supported?
    - Who can modify the data?
    - Is auditing needed?
- Failure Modes
    - Is design handles partial failures?
    - What is system behavior in case of failure?
    - Will it auto-recover, or requires manual operations?
- Availability
    - What kind of AV need to be supported
    - What external dependencies are you bringing?
    - What risk are you accepting with those dependencies?
- Security
    - One more 1 for most teams.
    - Disproportionally high focus on security.

Tips for Review
- Help to solve the problem, do not solve it yourself
- Avoid focusing on wrong problem
- Do not criticize person
- Be constructive
- Be balanced, pragmatic.
- Listen presenter.
