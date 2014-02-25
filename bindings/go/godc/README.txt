dyncall go bindings
Copyright 2014 Tassilo Philipp
February 23, 2014


SIGNATURE FORMAT

  format: "xxxxx)y"

    x is positional parameter-type charcode

    'B' C++: bool             <- Go: all types @@@
    'c' C: char               <- Go: int8,C.schar
    'C' C: unsigned char      <- Go: uint8,byte,C.uchar
    's' C: short              <- Go: int16,C.sshort
    'S' C: unsigned short     <- Go: uint16,C.ushort
    'i' C: int                <- Go: int32,C.sint
    'I' C: unsigned int       <- Go: uint32,C.uint
    'j' C: long               <- Go: int32,rune,C.slong
    'J' C: unsigned long      <- Go: uint32,C.ulong
    'l' C: long long          <- Go: int64,C.slonglong
    'L' C: unsigned long long <- Go: uint64,C.ulonglong
    'f' C: float              <- Go: float32,C.float
    'd' C: double             <- Go: float64,C.double
    'p' C: void*              <- Go: *,[],unsafe.Pointer
    'Z' C: void*              <- Go: string

    y is result-type charcode  

    'v' C: void               -> Go: (nothing)
    'B' C: bool               -> Go: all types @@@
    'c' C: char               -> Go: int8
    'C' C: unsigned char      -> Go: uint8,byte
    's' C: short              -> Go: int16
    'S' C: unsigned short     -> Go: uint16
    'i' C: int                -> Go: int32
    'I' C: unsigned int       -> Go: uint32
    'j' C: long               -> Go: int32,rune
    'J' C: unsigned long      -> Go: uint32
    'l' C: long long          -> Go: int64
    'L' C: unsigned long long -> Go: uint64
    'f' C: float              -> Go: float32
    'd' C: double             -> Go: float64
    'p' C: void*              -> Go: unsafe.Pointer
    'Z' C: void*              -> Go: string


-> Note that signature suffixes used to indicate calling
-> conventions, are not supported yet! @@@
