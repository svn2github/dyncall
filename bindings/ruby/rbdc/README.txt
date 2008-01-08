dyncall ruby bindings
Copyright 2007 Tassilo Philipp
December 20, 2007


SIGNATURE FORMAT

  format: "xxxxx)y"

    x is positional parameter-type charcode

    'b' C++: bool         <- Ruby: TrueClass, FalseClass, NilClass, Fixnum
    'c' C: char           <- Ruby: Fixnum
    's' C: short          <- Ruby: Fixnum
    'i' C: int            <- Ruby: Fixnum
    'l' C: long           <- Ruby: Fixnum
    'L' C: long long      <- Ruby: Fixnum
    'f' C: float          <- Ruby: Float
    'd' C: double         <- Ruby: Float
    'p' C: void*          <- Ruby: String @@@

    y is result-type charcode  

    'v' C: void           -> Ruby: NilClass
    'b' C: bool           -> Ruby: TrueClass, FalseClass
    'c' C: char           -> Ruby: Fixnum
    's' C: short          -> Ruby: Fixnum
    'i' C: int            -> Ruby: Fixnum
    'l' C: long           -> Ruby: Fixnum
    'L' C: long long      -> Ruby: Fixnum
    'f' C: float          -> Ruby: Float
    'd' C: double         -> Ruby: Float
    'p' C: void*          -> unsupported at the moment @@@
