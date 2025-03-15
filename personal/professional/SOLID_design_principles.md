# SOLID principles

Defined by Robert C. Martin
https://en.wikipedia.org/wiki/Robert_C._Martin
in his book
https://www.amazon.com/Software-Development-Principles-Patterns-Practices/dp/0135974445/ref=sr_1_1?s=books&ie=UTF8&qid=1378755964&sr=1-1&keywords=robert+c+martin

Also, consider to refer to course https://www.udemy.com/patterns-cplusplus/

S - Single Responsibility Principle
- A class should only have one reason to change
- Separation of concerns - different classes handling different, independent tasks/problems

O - Open-Closed Principle
- Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification.
- Use OO paradigm and inheritance instead of modifying already written and tested class in order to extend functionality.

L - Liskov Substitution Principle
- Child classes should never break the parent class' type definitions.
- Subtypes must be substitutable for their base types.
- Functions that use pointers to base classes must be able to use objects of derived classes without knowing it.

I - Interface Segregation Principle
- Do not put too much into an interface; split into separate interfaces
- YAGNI - You Ain't Going to Need It

D - Dependency Inversion Principle
- High-level modules should not depend on low-level modules. Both should depend on abstractions.
- Abstractions should not depend upon details. Details should depend upon abstractions.

# KISS principle
https://en.wikipedia.org/wiki/KISS_principle
"Keep It Short and Simple" OR "Keep It Simple and Stupid"
