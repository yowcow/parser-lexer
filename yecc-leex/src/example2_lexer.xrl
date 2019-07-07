%% Leex lexical analyzer generator
%% simple tokenizer example

Definitions.

INTEGER     = (\-)?[1-9][0-9]*
SCIENTIFIC  = ((E|e)(\+|\-)?[0-9]+)?
DQ_STRING   = \"[^\"]*\"
SQ_STRING   = \'[^\']*\'
PERL_STRING = q\{[^\}]*\}
BLANK       = [\n\s\t]

Rules.

{INTEGER} :
    {token, {integer, TokenLine, list_to_integer(TokenChars)}}.

{INTEGER}\.[0-9]+{SCIENTIFIC} :
    {token, {float, TokenLine, list_to_float(TokenChars)}}.

\"\" :
    {token, {string, TokenLine, ""}}.

\'\' :
    {token, {string, TokenLine, ""}}.

{DQ_STRING} :
    {token, {string, TokenLine, unquote_string(TokenChars, TokenLen)}}.

{SQ_STRING} :
    {token, {string, TokenLine, unquote_string(TokenChars, TokenLen)}}.

{PERL_STRING} :
    {token, {string, TokenLine, string:sub_string(TokenChars, 3, TokenLen - 1)}}.

{BLANK} : skip_token.

Erlang code.
unquote_string(Chars, Len) -> string:sub_string(Chars, 2, Len - 1).
