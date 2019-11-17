replaceInList([_|T], 0, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
        replaceInList(H, Column, Value, HNew).

replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
        Row > 0,
        Row1 is Row - 1,
        replaceInMatrix(T, Row1, Column, Value, TNew).

getValueFromList([H|_], 0, Value) :-
        Value = H.

getValueFromList([_|T], Index, Value) :-
        Index > 0,
        Index1 is Index - 1,
        getValueFromList(T, Index1, Value).

getValueFromMatrix([H|_], 0, Column, Value) :-
        getValueFromList(H, Column, Value).

getValueFromMatrix([_|T], Row, Column, Value) :-
        Row > 0,
        Row1 is Row - 1,
        getValueFromMatrix(T, Row1, Column, Value).

/*Verifica se o tabuleiro está cheio, confirmando se não há nenhuma célula
‘empty’ no tabuleiro.*/
checkFullBoard(Board) :-
      \+ (append(_, [R|_], Board),
	append(_, ['empty'|_], R)).