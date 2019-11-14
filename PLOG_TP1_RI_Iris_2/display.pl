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


symbol(null, '     ').
symbol(red, '  R  ').
symbol(orange, '  O  ').
symbol(yellow, '  Y  ').
symbol(green, '  G  ').
symbol(pink, '  P  ').
symbol(empty, '  .  ').


symbol(black, '  1  ').
symbol(white, '  2  ').

letter(1, 'A').
letter(2, 'B').
letter(3, 'C').
letter(4, 'D').
letter(5, 'E').
letter(6, 'F').
letter(7, 'G').
letter(8, 'H').
letter(9, 'I').
letter(10, 'J').
letter(11, 'K').

printBoard(X) :-
    nl,
    write('       1    2    3    4    5    6    7    8    9    10   11  \n'),
    write('   |--------------------------------------------------------|\n\n'),
    printMatrix(X, 1).

printMatrix([], 12).

printMatrix([Head|Tail], N) :-
    letter(N, L),
    write(' '),
    write(L),
    N1 is N + 1,
    write(' | '),
    printLine(Head),
    write('\n\n'),
    printMatrix(Tail, N1).

printLine([]).

printLine([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    printLine(Tail).