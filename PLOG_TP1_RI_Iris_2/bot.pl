
/*Gera um linha e coluna aleatória, verifica se é uma jogada válida, ou seja, 
se é uma célula que está nas linhas de visão de algum worker e se a célula está 
atualmente vazia. Caso seja válida, ele devolve essa linha e coluna, caso 
contrário este predicado chama-se a si própria para tentar gerar uma nova posição.*/
generatePlayerMove(Board, Row, Column, Value, Res):-
    random(0,11,RandomRow),
    random(0,11,RandomColumn),
    (isEmptyCell(Board, RandomRow, RandomColumn, ResIsEmptyCell, Value), ResIsEmptyCell=:=1,
        Row is RandomRow, Column is RandomColumn, Value \= empty, Res is 1; Res is 0);
        generatePlayerMove(Board, Row, Column, Value, Res).
