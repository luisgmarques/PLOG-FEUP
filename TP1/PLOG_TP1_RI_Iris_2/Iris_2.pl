emptyBoard([[null, null, null,           red, orange, yellow, green, pink, red,                   null, null],
           [null, null,            pink, empty, empty, empty, empty, empty, orange,              null, null],
           [null, null,         green, empty, empty, empty, empty, empty, empty, yellow,               null],
           [null,           yellow, empty, empty, empty, empty, empty, empty, empty, green,            null],
           [null,        orange, empty, empty, empty, empty, empty, empty, empty, empty, pink              ],
           [            red, empty, empty, empty, empty, empty, empty, empty, empty, empty, red            ],
           [             pink, empty, empty, empty, empty, empty, empty, empty, empty, orange,         null],
           [null,           green, empty, empty, empty, empty, empty, empty, empty, yellow,            null],
           [null,              yellow, empty, empty, empty, empty, empty, empty, green,          null, null],
           [null, null,           orange, empty, empty, empty, empty, empty, pink,               null, null],
           [null, null,              red, pink, green, yellow, orange, red,               null, null, null]]).

midBoard([[null, null, null, red, orange, white, green, pink, red, null, null],
           [null, null, pink, empty, empty, white, empty, empty, orange, null, null],
           [null, null, black, empty, empty, empty, white, empty, empty, yellow, null],
           [null, yellow, black, empty, empty, empty, white, empty, empty, green, null],
           [null, orange, empty, black, empty, empty, empty, empty, empty, empty, pink],
           [red, empty, empty, black, black, black, empty, white, empty, empty, red],
           [pink, empty, empty, empty, empty, empty, white, empty, empty, orange, null],
           [null, green, empty, empty, empty, empty, white, empty, empty, yellow, null],
           [null, yellow, empty, empty, white, black, empty, black, black, null, null],
           [null, null, orange, empty, empty, white, empty, empty, pink, null, null],
           [null, null, red, pink, green, white, orange, red, null, null, null]]).

fullBoard([[null, null, null, black, black, white, black, white, white, null, null],
           [null, null, white, empty, empty, white, empty, empty, black, null, null],
           [null, null, black, empty, empty, empty, white, empty, empty, black, null],
           [null, white, black, empty, empty, empty, white, empty, black, white, null],
           [null, white, white, black, empty, empty, empty, black, empty, empty, black],
           [ black, empty, white, black, black, black, black, white, black, empty, black],
           [ black, empty, white, black, black, empty, white, empty, empty, white, null],
           [null, white, white, empty, white, empty, white, empty, empty, white, null],
           [null, black, black, white, white, black, white, black, black, null, null],
           [null, null, black, empty, white, white, black, empty, white, null, null],
           [null, null, white, white, black, white, black, black, null, null, null]]).

symbol(null, ' * ').
symbol(red, ' R ').
symbol(orange, ' O ').
symbol(yellow, ' Y ').
symbol(green, ' G ').
symbol(pink, ' P ').
symbol(empty, ' . ').


symbol(black, ' 1 ').
symbol(white, ' 2 ').

printBoard([Head|Tail]) :-
    write('|'),
    printLine(Head),
    nl,
    printBoard(Tail).
printBoard([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write('|'),
    printLine(Tail).
printLine([]).

display_game(X) :- emptyBoard(X), printBoard(X); midBoard(X), printBoard(X); fullBoard(X), printBoard(X).
    