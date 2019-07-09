Definitions.

NUM        = [0-9]+
SCIENTIFIC = ((e|E)(\+|\-)[0-9]+)?
STRING     = "(\\.|[^\"\\])*"
KEYWORDS   = null|true|false
SYMBOLS    = [\{\}\[\]\:\,]
WHITESPACE = [\s\t\n\r]+

Rules.

(\-|\+)?{NUM} :
    {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
(\-|\+)?{NUM}\.{NUM}{SCIENTIFIC} :
    {token, {float, TokenLine, list_to_float(TokenChars)}}.
{STRING} :
    {token, {string, TokenLine, unquote(TokenChars)}}.
{KEYWORDS} :
    {token, {list_to_atom(TokenChars), TokenLine}}.
{SYMBOLS} :
    {token, {list_to_atom(TokenChars), TokenLine}}.
{WHITESPACE} :
    skip_token.

Erlang code.

unquote(Str) ->
    Uq = string:sub_string(Str, 2, length(Str) - 1),
    lists:flatten(string:replace(Uq, "\\", "", all)).
