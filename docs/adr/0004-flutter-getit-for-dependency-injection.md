# flutter getit for dependency injection

Date: 2021-07-17

## Decision

We chose GetIt (https://pub.dev/packages/get_it) because it has a simple syntax and is very flexible. The cons of this framework is that it allows the developer to use it in any part of the code. Although to remedy this problem, here in this project we centralize the use of GetIt only on Container (module injection setup), navigation and main file.