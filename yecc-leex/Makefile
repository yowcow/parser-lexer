YRLS := $(shell find src -name "*.yrl")
PARSERS := $(foreach f,$(basename $(YRLS)),$(f)_parser.erl)

all: $(PARSERS)

%_parser.erl: %.yrl
	rm -f $@
	erl -noshell -eval 'yecc:file("$<", [{parserfile, "$@"}]), halt(0).'

test:
	rebar3 eunit

clean:
	find src -name '*_parser.erl' -exec rm {} \;
	rm -rf _build

.PHONY: all test
