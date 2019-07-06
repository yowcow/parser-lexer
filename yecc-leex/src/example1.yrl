Header "%% Oh, hi"
"%% Hello world"
"%% Good-bye!".

Nonterminals commands command elements element.

Terminals atom integer string var '(' ')' ','.

Rootsymbol commands.

commands -> command              : ['$1'].
commands -> command ',' commands : ['$1' | '$3'].

command -> '(' ')'.
command -> '(' elements ')' : '$2'.

elements -> element              : ['$1'].
elements -> element ',' elements : ['$1' | '$3'].

element -> atom    : value_of('$1').
element -> integer : value_of('$1').
element -> string  : value_of('$1').
element -> var     : value_of('$1').

Erlang code.
value_of(Token) ->
    element(3, Token).
%line_of(Token) ->
%    element(2, Token).
