-module(example2_lexer_tests).

-include_lib("eunit/include/eunit.hrl").

tokenize_test_() ->
    Cases = [
        {
            "multiple integers",
            "data/example2.txt",
            [
                {integer, 1, 123},
                {integer, 1, -234},
                {integer, 3, 345},
                {float, 5, 1.0},
                {float, 5, -0.011},
                {float, 5, 1230.0},
                {string, 7, ""},
                {string, 7, ""},
                {string, 7, ""},
                {string, 7, ""},
                {string, 9, " 'hello world' "},
                {string, 10, " \"HELLO WORLD\" "},
                {string, 12, "Perl-like quoted string!"}
            ]
        }
    ],
    F = fun({Name, File, Expected}) ->
        {ok, Binary} = file:read_file(File),
        {ok, Actual, _} = example2_lexer:string(binary_to_list(Binary)),
        {Name, ?_assertEqual(Expected, Actual)}
    end,
    lists:map(F, Cases).
