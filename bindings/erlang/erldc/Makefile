ERLANG_INST_DIR = /usr/lib64/erlang
DYNCALL_SRC_PATH=../dyncall/trunk/dyncall

OUTPUTS = priv/erldc.so ebin/dyncall.beam

all: $(OUTPUTS)

# -lm is temporary until dynload is implemented
priv/erldc.so: c_src/dyncallnif.c
	[ -d priv ] || mkdir priv
	cc -o $@ -fPIC -shared \
	-I $(ERLANG_INST_DIR)/usr/include -I $(DYNCALL_SRC_PATH) \
	$(DYNCALL_SRC_PATH)/dyncall/*.o \
	c_src/dyncallnif.c

priv/erldc_testtargets.so: c_src/erldctesttargets.c
	[ -d priv ] || mkdir priv
	cc -o $@ -shared -fPIC $^

ebin/dyncall.beam: src/dyncall.erl
	[ -d ebin ] || mkdir ebin
	erlc +debug_info -o ebin $^

# TODO: compile src/dyncall.app.src
# How erlang.mk does it - too gnu?
# app: ebin/$(PROJECT).app
# 	$(eval MODULES := $(shell find ebin -type f -name \*.beam \
# 		| sed "s/ebin\//'/;s/\.beam/',/" | sed '$$s/.$$//'))
# 	$(appsrc_verbose) cat src/$(PROJECT).app.src \
# 		| sed "s/{modules,[[:space:]]*\[\]}/{modules, \[$(MODULES)\]}/" \
# 		> ebin/$(PROJECT).app

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
		ct_run -pa ebin -logdir log -suite linkload_SUITE call_SUITE
	rm -f test/*.beam

clean:
	rm -rf priv/* ebin/* test/*.beam

.PHONY: clean all tests build-plt dialyze
