-module(json_parser_tests).

-include_lib("eunit/include/eunit.hrl").

parse_test_() ->
    Cases = [
        {
            "integer",
            "data/json1.json",
            123
        },
        {
            "float",
            "data/json1-1.json",
            1.2345
        },
        {
            "scientific float notation 1",
            "data/json1-2.json",
            1.234 * 0.00001
        },
        {
            "scientific float notation 2",
            "data/json1-3.json",
            1.234 * 100000
        },
        {
            "string",
            "data/json2.json",
            "ho\"ge\""
        },
        {
            "array of integers",
            "data/json3.json",
            [1, 2, 3, [4, 5, 6], []]
        },
        {
            "object",
            "data/json4.json",
            #{
                "hoge" => 123,
                "fuga" => 234,
                "foo" => #{},
                "bar" => [],
                "buz" => null,
                "a" => #{
                    "name" => "Hoge Fuga",
                    "age" => 999,
                    "keywords" => [
                        "foo",
                        #{ "value" => "bar" },
                        ["buz"]
                    ]
                }
            }
        }
    ],
    F = fun({Name, File, Expected}) ->
        {ok, Binary} = file:read_file(File),
        {_, Tokens, _} = json_lexer:string(binary_to_list(Binary)),
        {ok, Actual} = json_parser:parse(Tokens),
        {Name, ?_assertEqual(Expected, Actual)}
    end,
    lists:map(F, Cases).
