-module(example1_parser_tests).

-include_lib("eunit/include/eunit.hrl").

parse_test() ->
    {ok, Binary} = file:read_file("data/example1.txt"),
    {_, Tokens, _} = erl_scan:string(binary_to_list(Binary)),
    {ok, Actual} = example1_parser:parse(Tokens),
    Expected = [
        [hoge],
        [fuga],
        [foo, bar, buz],
        [hoge],
        [1, 2, 3],
        ["hello", "world"],
        ['Hello', 'World']
    ],
    ?assertEqual(Expected, Actual).
