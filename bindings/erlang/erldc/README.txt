TODO
- functions in dyncall_callf.h
- replace load_nif + on_load with something less awkward.  Consider
  removing on_load entirely and requiring dir as arg to dyncall:load_nif
  ... actually, this is probably fine, see asn1 app's nif
- make install
- Makefile compiles src/dyncall.app.src

BUILDING
'make DYNCALL_SRC_PATH=../dyncall ERLANG_INST_DIR=/erlang/in/this/dir all' to build

'make tests'

'sudo make ERLANG_INST_DIR=/erlang/in/this/dir install'

Erlang doesn't use pkg-config, so you must specify ERLANG_INST_DIR, 
mostly so headers can be found.

The makefile is meant to be portable, at least across *nix.

USING
See test/call_SUITE.erl for several examples.

Dyncall is built as an OTP library application.  So, there's nothing
to start or stop.

NOTES
