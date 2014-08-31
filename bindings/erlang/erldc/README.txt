=TODO
- implement struct
- use/test dcGetError
  - error codes into .hrl
- Call modes
- replace load_nif + on_load with something less awkward.  Consider
  removing on_load entirely and requiring dir as arg to dyncall:load_nif
- make install
- Makefile compiles src/dyncall.app.src
- move limits (e.g. MAX_VMS) into makefile so tests can have the value too.
  - then, test limits
  - or, replace fixed-length arrays with proper vectors 
    - enif_tsd_key_create and friends?
    - or, does dyncall have something?
  - or, replace with _resource handles, with each handle type being
    a dedicated resource

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
