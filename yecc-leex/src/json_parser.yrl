Header "%% Oh hi!"
"%% This is my JSON parser!".

Nonterminals elements kv_elements element.

Terminals string integer float atom '[' ']' '{' '}' ':' ','.

Rootsymbol element.

elements -> element              : ['$1'].
elements -> element ',' elements : ['$1' | '$3'].

kv_elements -> string ':' element                 : [{value_of('$1'), '$3'}].
kv_elements -> string ':' element ',' kv_elements : [{value_of('$1'), '$3'} | '$5'].

element -> '[' ']'          : [].
element -> '[' elements ']' : '$2'.

element -> '{' '}'             : #{}.
element -> '{' kv_elements '}' : maps:from_list('$2').

element -> string  : value_of('$1').
element -> integer : value_of('$1').
element -> float   : value_of('$1').
element -> atom    : ok_atom(value_of('$1')).

Erlang code.
value_of(Token) -> element(3, Token).

ok_atom(null) -> null.
