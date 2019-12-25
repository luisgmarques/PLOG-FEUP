/* Carrega o tabuleiro e chama o predicado 
    responsavel pela a logica do jogo */
startGame(Player1, Player2) :-
    emptyBoard(InitialBoard),
    (
    (Player1 == 'P', 
    firstPlay(InitialBoard, Player1, NewBoard),
    printBoard(NewBoard),
    gameLoop(NewBoard, Player2, Player1));
    (Player1 == 'C',
    choose_first_move(InitialBoard, NewRowIndex, NewColumnIndex, Value),
    printComputerFirstMove(InitialBoard, NewRowIndex, NewColumnIndex, NewBoard, Value),
    gameLoop(NewBoard, Player2, Player1)
    ),
    checkBlackScore(NewBoard, 0, 0, 0),
    checkWhiteScore(NewBoard, 0, 0, 0)).

% Verifica se o tabuleiro está cheio
game_over(Player, Board) :-
    checkFullBoard(Board).


/* Primeira jogada. Colocação de uma peça pelo o jogador preto */
firstPlay(Board, Player1, NewBoard) :-
    printBoard(Board),
    write('\n--------------------- PLAYER [b]lack ----------------------\n\n'),
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkFirstPlay(Board, Player1, NewBoard, ColumnIndex, RowIndex).

checkFirstPlay(Board, Player1, NewBoard, ColumnIndex, RowIndex) :-
    (
        (
    isValidCell(Board, RowIndex, ColumnIndex, ResIsValid, Value), ResIsValid =:= 1),
                        replaceInMatrix(Board, RowIndex, ColumnIndex, black, NewBoard);
                        (write('INVALID MOVE: That cell is not valid, please try again!\n\n'),
            firstPlay(Board, Player1, NewBoard))).

/* Princial predicado do jogo.
    O jogo vai sendo jogado por cada jogador
    até o tabuleiro estiver cheio */
gameLoop(Board, Player1, Player2) :-
      whitePlayerTurn(Board, NewBoard, Player1),
      (
            (game_over('white', NewBoard), write('\nThanks for playing!\n'));
            (blackPlayerTurn(NewBoard, FinalBoard, Player2),
                  (
                        (game_over('black', FinalBoard), write('\nThanks for playing!\n'));
                        (gameLoop(FinalBoard, Player1, Player2))
                  )
            )
      ).
    

/* Jogada feita pelo o jogador preto */
blackPlayerTurn(Board, NewBoard, 'P') :-
    printBoard(Board),
    write('\n--------------------- PLAYER [b]lack ----------------------\n\n'),
    move(Board, black, NewBoard),
    printBoard(NewBoard).

/* Jogada feita pelo o computador preto */
blackPlayerTurn(Board, NewBoard, 'C') :-
      write('\n------------------- COMPUTER [b]lack --------------------\n\n'),
      write('Thinking... \n'),
      choose_move(Board, NewRowIndex, NewColumnIndex, Value),
      printComputerPlayBlack(Board, NewRowIndex, NewColumnIndex, NewBoard, Value).

/* Imprime na consola a jogada do computador preto */
printComputerPlayBlack(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value) :-
    (Value \== empty, !,
    (replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, black, NewBoard), 
      NewRowIndex1 is 10 - NewRowIndex, NewColumnIndex1 is 10 - NewColumnIndex,
      replaceInMatrix(NewBoard,  NewRowIndex1, NewColumnIndex1, black, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printComputerMove(NewRowIndex1, NewColumnIndex1)
      );

      replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, black, NewBoard),
      choose_second_move(NewBoard, Row, Column, Value),
      replaceInMatrix(NewBoard,  Row, Column, black, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printComputerMove(Row, Column)
      ),
    
      printBoard(FinalBoard).

/* Jogada feita pelo o jogador branco */
whitePlayerTurn(NewBoard, FinalBoard, 'P') :-
      printBoard(NewBoard),
      write('\n--------------------- PLAYER [w]hite ---------------------\n\n'),
      move(NewBoard, white, FinalBoard),
      printBoard(FinalBoard).

/* Jogada feita pelo o computador branco */
whitePlayerTurn(Board, FinalBoard, 'C') :-
       write('\n------------------- COMPUTER [w]hite --------------------\n\n'),
       write('Thinking... \n'),
       choose_move(Board, NewRowIndex, NewColumnIndex, Value),
       printComputerPlayWhite(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value).

/* Imprime na consola a jogada do computador branco */
printComputerPlayWhite(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value) :-
    (Value \== empty, !,
    (replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, white, NewBoard), 
      NewRowIndex1 is 10 - NewRowIndex, NewColumnIndex1 is 10 - NewColumnIndex,
      replaceInMatrix(NewBoard,  NewRowIndex1, NewColumnIndex1, white, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printComputerMove(NewRowIndex1, NewColumnIndex1)
      );

      replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, white, NewBoard),
      choose_second_move(NewBoard, Row, Column, Value),
      replaceInMatrix(NewBoard,  Row, Column, white, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printComputerMove(Row, Column)
      ),
    
      printBoard(FinalBoard).

/* Imprime a primeira jogada feita pelo o computador */
printComputerFirstMove(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value) :-
      replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, black, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex)
      ,
    
      printBoard(FinalBoard).

% Mostra na consola a jogada do computador
printComputerMove(NewRowIndex, NewColumnIndex):-
      NewRow is NewRowIndex + 1,
      NewColumn is NewColumnIndex + 1,
      letter(NewRow, RowLetter),
      write(' > Computer added a piece in the cell [row: '), write(RowLetter), write(' column: '), write(NewColumn), write(']\n').


/* Faz a gestão da jogada feita pelo o jogador */
move(Board, Player, NewBoard) :-
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkMove(Board, Player, NewBoard, ColumnIndex, RowIndex).

/* Segunda jogada */
secondPlay(Board, Player, NewBoard) :-
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkSecondPlay(Board, Player, NewBoard, ColumnIndex, RowIndex).

/* Verifica se a segunda jogada é válida */
checkSecondPlay(Board, Player, NewBoard, ColumnIndex, RowIndex) :-
    (
        (
    isValidCell(Board, RowIndex, ColumnIndex, ResIsValid, Value), ResIsValid =:= 1),
                        replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard);
                        (write('INVALID MOVE: That cell is not valid, please try again!\n\n'),
            secondPlay(Board, Player, NewBoard))).


/* Verifica se a célula não está ocupada */
isEmptyCell(Board, Row, Column, Res, Value) :-
    ((value(Board, Row, Column, Value), Value \== null, Value \== black, Value \== white, !, 
    Res is 1);
    Res is 0).

/* Predicado auxiliar à segunda jogada */
isValidCell(Board, Row, Column, Res, Value) :-
    ((value(Board, Row, Column, Value), Value == empty, !, 
    Res is 1);
    Res is 0).

/* Verifica se jogada é válida. 
    Caso nao seja apresenta uma mensagem
    ão jogador e pede para jogar novamente */
checkMove(Board, Player, NewBoard, ColumnIndex, RowIndex):-
      (
          (Player == white; Player == black),
            (
                       (isEmptyCell(Board, RowIndex, ColumnIndex, ResIsValid, Value),ResIsValid =:= 1),
                        (
                        Value \== empty, % Verifica se jogou em celulas coloridas, ocupando a celula onde jogou e a oposta
                            (replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewNewBoard), 
                            RowIndex1 is 10 - RowIndex, ColumnIndex1 is 10 - ColumnIndex,
                            replaceInMatrix(NewNewBoard, RowIndex1, ColumnIndex1, Player, NewBoard));
                            % Jogada em celula empty
                            replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewNewBoard),
                            secondPlay(NewNewBoard, Player, NewBoard)
                        );
            (write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
            move(Board, Player, NewBoard)))).


/* Score  - WIP */
checkBlackScore(_, 11, 11, Amount) :-
    write('\n Black score: '),
    write(Amount),
    write('\n').
checkBlackScore(Board, ColumnIndex, RowIndex, Amount) :- 
    value(Board, RowIndex, ColumnIndex, Value),
    ColumnIndex1 is ColumnIndex + 1,
    (ColumnIndex1 == 11, RowIndex1 is RowIndex + 1, ColumnIndex1 is 0),
    (Value == black, 
    Amount1 is Amount + 1,
    checkBlackScore(Board, ColumnIndex1, RowIndex1, Amount1));
    checkBlackScore(Board, ColumnIndex1, RowIndex1, Amount).


checkWhiteScore(_, 11, 11, Amount) :-
    write('\n White score: '),
    write(Amount),
    write('\n').
checkWhiteScore(Board, ColumnIndex, RowIndex, Amount) :- 
    (
        value(Board, RowIndex, ColumnIndex, Value),
        ColumnIndex1 is ColumnIndex + 1,
        ColumnIndex1 == 11, (RowIndex1 is RowIndex + 1, ColumnIndex1 is 0);
        (Value == white, 
        Amount1 is Amount + 1,
        checkWhiteScore(Board, ColumnIndex1, RowIndex1, Amount1));
        checkWhiteScore(Board, ColumnIndex1, RowIndex1, Amount)
    ).


    
