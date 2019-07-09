-module(json_lexer_tests).

-include_lib("eunit/include/eunit.hrl").

string_test_() ->
    Cases = [
        {
            "true",
            "true",
            [{true, 1}]
        },
        {
            "false",
            "false",
            [{false, 1}]
        },
        {
            "[]{}:,",
            "[]{}:,",
            [
                {'[', 1},
                {']', 1},
                {'{', 1},
                {'}', 1},
                {':', 1},
                {',', 1}
            ]
        },
        {
            "string",
            "\"hoge \\\"fuga\\\"\"",
            [
                {string, 1, "hoge \"fuga\""}
            ]
        },
        {
            "positive integer",
            "+1234",
            [
                {integer, 1, 1234}
            ]
        },
        {
            "negative integer",
            "-1234",
            [
                {integer, 1, -1234}
            ]
        },
        {
            "positive float",
            "1.234",
            [
                {float, 1, 1.234}
            ]
        },
        {
            "negative float",
            "-1.234",
            [
                {float, 1, -1.234}
            ]
        },
        {
            "scientific float",
            "1.234e+4",
            [
                {float, 1, 12340.0}
            ]
        },
        {
            "scientific float",
            "1.234E-4",
            [
                {float, 1, 0.0001234}
            ]
        }
    ],
    F = fun({Name, Input, Expected}) ->
        {Name, fun() ->
            Result = json_lexer:string(Input),
            {ok, Tokens, _} = Result,
            ?assertEqual(Expected, Tokens)
        end}
    end,
    lists:map(F, Cases).
