all:
	rebar3 compile

test:
	rebar3 eunit

clean:
	find src -name '*_parser.erl' -exec rm {} \;
	rm -rf _build

.PHONY: all test
