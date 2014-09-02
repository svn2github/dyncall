# ERLANG_INC is used for -I, below, so add paths where it might be on linux, freebsd, etc.
ERLANG_INC=-I /usr/lib64/erlang/usr/include -I /usr/local/lib/erlang/usr/include
DYNCALL_SRC_PATH=../../../dyncall

OUTPUTS = priv/erldc.so ebin/dyncall.beam

all: $(OUTPUTS)

priv/erldc.so: c_src/dyncallnif.c
	[ -d priv ] || mkdir priv
	cc -o $@ -fPIC -shared \
	$(ERLANG_INC) -I $(DYNCALL_SRC_PATH) \
	$(DYNCALL_SRC_PATH)/dyncall/*.o \
	c_src/dyncallnif.c

priv/erldc_testtargets.so: c_src/erldctesttargets.c
	[ -d priv ] || mkdir priv
	cc -o $@ -shared -fPIC c_src/erldctesttargets.c

ebin/dyncall.beam: src/dyncall.erl
	erlc +debug_info -o ebin src/dyncall.erl

# Dialyzer, credit to erlang.mk 
DIALYZER_OPTS ?= -Werror_handling -Wrace_conditions \
	-Wunmatched_returns # -Wunderspecs

build-plt: 
	rm -f test/*.beam
	dialyzer --build_plt --output_plt dyncall.plt \
		--apps erts kernel stdlib .

dialyze: $(OUTPUTS)
	dialyzer --src src --plt dyncall.plt --no_native $(DIALYZER_OPTS)

tests: $(OUTPUTS) priv/erldc_testtargets.so
	mkdir -p log
	# Add priv to runtime ld path so we get test targets
	export LD_LIBRARY_PATH=$$(pwd)/priv:${LD_LIBRARY_PATH}; \
		ct_run -pa ebin -logdir log \
			-suite linkload_SUITE call_SUITE misc_SUITE
	rm -f test/*.beam

clean:
	rm -rf priv/* ebin/*.beam test/*.beam

.PHONY: clean all tests build-plt dialyze
