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


symbol(null, ' * ').
symbol(red, ' R ').
symbol(orange, ' O ').
symbol(yellow, ' Y ').
symbol(green, ' G ').
symbol(pink, ' P ').
symbol(empty, ' . ').


symbol(black, ' 1 ').
symbol(white, ' 2 ').

letter(1, L) :- L='A'.
letter(2, L) :- L='B'.
letter(3, L) :- L='C'.
letter(4, L) :- L='D'.
letter(5, L) :- L='E'.
letter(6, L) :- L='F'.
letter(7, L) :- L='G'.
letter(8, L) :- L='H'.
letter(9, L) :- L='I'.
letter(10, L) :- L='J'.
letter(11, L) :- L='K'.

printBoard(X) :-
    nl,
    write('   |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  10 |  11 |\n'),
    write('---|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|\n'),
    printMatrix(X, 1).

printMatrix([], 12).

printMatrix([Head|Tail], N) :-
    letter(N, L),
    write(' '),
    write(L),
    N1 is N + 1,
    write(' | '),
    printLine(Head),
    write('\n---|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|\n'),
    printMatrix(Tail, N1).

printLine([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    write(' | '),
    printLine(Tail).

display_game(X) :- emptyBoard(X), printBoard(X).