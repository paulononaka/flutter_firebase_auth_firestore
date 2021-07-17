# Add Freezed to help with immutable objects and enable sealed classes

Date: 2021-07-17

## Decision

While there are many code-generators available to help you deal with immutable objects, they usually come with a trade-off. Either they have a simple syntax but lack features, or they have very advanced features but with complex syntax. A typical example would be a "clone" method. Besides, we chose Freezed since it comes with Unions/Sealed classes extension. Coming from other languages, you may be used with features like "tagged union types" / sealed classes/pattern matching. These are powerful tools in combination with a type system, but Dart currently does not support them.