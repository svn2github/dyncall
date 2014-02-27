This document intends to layout a style to follow for language bindings,
depending on the nature of the language.


* Imperative:

  - Object oriented or prototype:

      Create 2 objects, one as a handle to each external library (e.g. extlib), one as a handle to a callvm

  - Without objects:

      Wrap dyncall as close as direct

  - Statically typed (and no direct way wrap types in a generic way and or RTTI):

      Expose all dcArg, etc. calls

  - RTTI:

      Write a single call function and let users pass arguments, directly



* Functional:

  @@@ ToDo



* Other language features

 - Namespaces/modules/packages

     Use and name dyncall or dc (@@@ choose one)

 - Function overloading or default arguments

     Use if available to define things like CallVM stack size; use independently named functions, otherwise
