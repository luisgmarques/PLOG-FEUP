manageRow(NewRow) :-
    readRow(Row),
    validateRow(Row, NewRow).

manageColumn(NewColumn) :-
    readColumn(Column),
    validateColumn(Column, NewColumn).

readRow(Row) :-
    write('  > Row    '),
    read(Row).

readColumn(Column) :-
    write('  > Column '),
    read(Column).

validateRow('a', NewRow) :-
    NewRow = 1.

validateRow('b', NewRow) :-
    NewRow = 2.

validateRow('c', NewRow) :-
    NewRow = 3.

validateRow('d', NewRow) :-
    NewRow = 4.

validateRow('e', NewRow) :-
    NewRow = 5.

validateRow('f', NewRow) :-
    NewRow = 6.

validateRow('g', NewRow) :-
    NewRow = 7.

validateRow('h', NewRow) :-
    NewRow = 8.

validateRow('i', NewRow) :-
    NewRow = 9.

validateRow('j', NewRow) :-
    NewRow = 10.

validateRow('k', NewRow) :-
    NewRow = 11.

validateRow(_, NewRow) :-
    write('ERROR: Row not valid!\n\n'),
    readRow(Input),
    validateRow(Input, NewRow).

validateColumn(1, NewColumn) :-
    NewColumn = 1.

validateColumn(2, NewColumn) :-
    NewColumn = 2.

validateColumn(3, NewColumn) :-
    NewColumn = 3.

validateColumn(4, NewColumn) :-
    NewColumn = 4.

validateColumn(5, NewColumn) :-
    NewColumn = 5.

validateColumn(6, NewColumn) :-
    NewColumn = 6.

validateColumn(7, NewColumn) :-
    NewColumn = 7.

validateColumn(8, NewColumn) :-
    NewColumn = 8.

validateColumn(9, NewColumn) :-
    NewColumn = 9.

validateColumn(10, NewColumn) :-
    NewColumn = 10.

validateColumn(11, NewColumn) :-
    NewColumn = 11.

validateColumn(_, NewColumn) :-
    write('ERROR: Column not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input, NewColumn).

