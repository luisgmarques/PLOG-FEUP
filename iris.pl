emptyBoard([[null, null, null, red, orange, yellow, green, blue, red, null, null],
           [null, null, blue, empty, empty, empty, empty, empty, orange, null, null],
           [null, null, green, empty, empty, empty, empty, empty, empty, yellow, null],
           [null, yellow, empty, empty, empty, empty, empty, empty, empty, green, null],
           [null, orange, empty, empty, empty, empty, empty, empty, empty, empty, blue],
           [red, empty, empty, empty, empty, empty, empty, empty, empty, empty, red],
           [blue, empty, empty, empty, empty, empty, empty, empty, empty, orange, null],
           [null, green, empty, empty, empty, empty, empty, empty, empty, yellow, null],
           [null, yellow, empty, empty, empty, empty, empty, empty, green, null, null],
           [null, null, orange, empty, empty, empty, empty, empty, blue, null, null],
           [null, null, red, blue, green, yellow, orange, red, null, null, null]]).

symbol(null, ' * ').
symbol(red, ' R ').
symbol(orange, ' O ').
symbol(yellow, ' Y ').
symbol(green, ' G ').
symbol(blue, ' P ').
symbol(empty, ' . ').


symbol(black, ' B ').
symbol(white, ' W ').

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

display_game(X) :- emptyBoard(X), printBoard(X).
    