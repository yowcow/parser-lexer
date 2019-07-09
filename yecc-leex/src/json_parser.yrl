Header "%% Oh hi!"
"%% This is my JSON parser!".

Nonterminals elements kv_pairs element.

Terminals string integer float null true false '[' ']' '{' '}' ':' ','.

Rootsymbol element.

elements -> element              : ['$1'].
elements -> element ',' elements : ['$1' | '$3'].

kv_pairs -> string ':' element              : [{value_of('$1'), '$3'}].
kv_pairs -> string ':' element ',' kv_pairs : [{value_of('$1'), '$3'} | '$5'].

element -> '[' ']'          : [].
element -> '[' elements ']' : '$2'.

element -> '{' '}'          : #{}.
element -> '{' kv_pairs '}' : maps:from_list('$2').

element -> string  : value_of('$1').
element -> integer : value_of('$1').
element -> float   : value_of('$1').
element -> null    : null.
element -> true    : true.
element -> false   : false.

Erlang code.
value_of(Token) -> element(3, Token).
