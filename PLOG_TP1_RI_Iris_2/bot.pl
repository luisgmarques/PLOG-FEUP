
/*Gera um linha e coluna aleatória, verifica se é uma jogada válida, ou seja, se a célula está 
atualmente vazia. Caso seja válida, ele devolve essa linha e coluna, caso 
contrário este predicado chama-se a si própria para tentar gerar uma nova posição.*/
choose_move(Board, Row, Column, Value):-
    
    random(0,11,RandomRow),
    random(0,11,RandomColumn),
    (isEmptyCell(Board, RandomRow, RandomColumn, ResIsEmptyCell, Value), ResIsEmptyCell=:=1,
        Row is RandomRow, Column is RandomColumn);
        generatePlayerMove(Board, Row, Column, Value).
