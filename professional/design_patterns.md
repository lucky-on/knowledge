Design Patterns

- Strategy
For:
How:
Prevents:

- Observer
When: We have single producer of events (E)/data (D), and multiple observers of E/D
For: to share data on time
How: One producer - multiple consumers, producer produce data/messages and multiple observers sing-up for updates, producer has map of object to notify, calls notify() to inform all observers, where in a loop calls each observer’s update().
Prevents: Unnecessary calls from observers to check for new portion of data.

- Factory Method
When: We have number of classes in system which derived from Base class (I), and we do not know which we want to construct on compile time. We “randomly” want to create A or B or C based on I.
For: Inbuilt logic to Object creation routine, add some randomness depending on whatever external statuses. So we build factory with business logic of Object creation.
How:
Prevents:

- Abstract Factory
When: While Factory Method constructs single object, Abstract Factory constructs multiple objects related to each other.
For example, when we need User/Platform/Browser specific/dependent UI
For:
How: Provides interface to create family of dependent or related projects.

- Decorator
For: 	To decorate this or that behavior of Base class. In run-time we can compose those wrappers in a way we want.
	To deprecate some functionality of base class, decorators can take care of it on their level but not to call Base class.
How: Decorator class IS and HAS base class. Base class has wrappers around. When data a passing from base to wrappers, Idea based on using kind of recursion, each wrapper calls it’s base class, while that one in turn calls his base class. Every decorator thinks that it wraps just one thing, it has no idea how many wrappers are there down the road.
On Method level we can add any number of methods depending on our scenario.
Prevents: Series class-explosion problem. Interface-aggregation problem.

- Command
What does it do: Incapsulates a request (in between two objects), letting you parametrize other objects with command object, you take a bunch of commands, put them in a list, execute Macro command, which consist of multiple small commands
Example: Smart homes, remote control

- Singelton

- Bridge
when:

For:
