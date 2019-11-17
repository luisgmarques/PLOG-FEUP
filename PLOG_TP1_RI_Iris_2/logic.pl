% Pergunta ao jogador onde quer jogar
move(Board, Player, NewBoard) :-
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkMove(Board, Player, NewBoard, ColumnIndex, RowIndex).

firstPlay(Board, Player, NewBoard) :-
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkFirstPlay(Board, Player, NewBoard, ColumnIndex, RowIndex).

secondPlay(Board, Player, NewBoard) :-
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkMove(Board, Player, NewBoard, ColumnIndex, RowIndex).

checkFirstPlay(Board, Player, NewBoard, ColumnIndex, RowIndex) :-
    (
        (
    isEmptyCell(Board, RowIndex, ColumnIndex, ResIsValid), ResIsValid =:= 1),
                        replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard);
                        (write('INVALID MOVE: That cell is not valid, please try again!\n\n'),
            firstPlay(Board, Player, NewBoard))).

% Verifica se o tabuleiro está cheio
game_over(Player, Board) :-
    checkFullBoard(Board).

% Mostra na consola a jogada do computador
printComputerMove(NewRowIndex, NewColumnIndex):-
      NewRow is NewRowIndex + 1,
      NewColumn is NewColumnIndex + 1,
      letter(NewRow, RowLetter),
      write(' > Computer added a piece in the cell [row: '), write(RowLetter), write(' column: '), write(NewColumn), write(']\n').

% 
startGame(Player1, Player2) :-
    emptyBoard(InitialBoard),
    gameLoop(InitialBoard, Player1, Player2).
    



gameLoop(Board, Player1, Player2) :-
      blackPlayerTurn(Board, NewBoard, Player1),
      (
            (game_over('black', NewBoard), write('\nThanks for playing!\n'));
            (whitePlayerTurn(NewBoard, FinalBoard, Player2),
                  (
                        (game_over('white', FinalBoard), write('\nThanks for playing!\n'));
                        (gameLoop(FinalBoard, Player1, Player2))
                  )
            )
      ),
      checkBlackScore(FinalBoard, 0, 0, 0),
    checkWhiteScore(FinalBoard, 0, 0, 0).
    

blackPlayerTurn(Board, NewBoard, 'P') :-
    printBoard(Board),
    write('\n--------------------- PLAYER [b]lack ----------------------\n\n'),
    move(Board, black, NewBoard).
    %printBoard(NewBoard).

blackPlayerTurn(Board, NewBoard, 'C') :-
      write('\n------------------- COMPUTER [b]lack --------------------\n\n'),
      write('Thinking... \n'),
      choose_move(Board, NewRowIndex, NewColumnIndex, Value),
      printComputerPlayBlack(Board, NewRowIndex, NewColumnIndex, NewBoard, Value).

printComputerPlayBlack(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value) :-
    (Value \== empty, !,
    (replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, black, NewBoard), 
      NewRowIndex1 is 10 - NewRowIndex, NewColumnIndex1 is 10 - NewColumnIndex,
      replaceInMatrix(NewBoard,  NewRowIndex1, NewColumnIndex1, black, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printComputerMove(NewRowIndex1, NewColumnIndex1)
      );

      replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, white, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex)
      ),
    
      printBoard(FinalBoard).

whitePlayerTurn(NewBoard, FinalBoard, 'P') :-
      printBoard(NewBoard),
      write('\n--------------------- PLAYER [w]hite ---------------------\n\n'),
      move(NewBoard, white, FinalBoard).
      %printBoard(FinalBoard).

whitePlayerTurn(Board, FinalBoard, 'C') :-
       write('\n------------------- COMPUTER [w]hite --------------------\n\n'),
       write('Thinking... \n'),
       choose_move(Board, NewRowIndex, NewColumnIndex, Value),
       printComputerPlayWhite(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value), sleep(1).


printComputerPlayWhite(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value) :-
    (Value \== empty, !,
    (replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, white, NewBoard), 
      NewRowIndex1 is 10 - NewRowIndex, NewColumnIndex1 is 10 - NewColumnIndex,
      replaceInMatrix(NewBoard,  NewRowIndex1, NewColumnIndex1, white, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex),
      printComputerMove(NewRowIndex1, NewColumnIndex1)
      );

      replaceInMatrix(Board,  NewRowIndex, NewColumnIndex, white, FinalBoard),
      printComputerMove(NewRowIndex, NewColumnIndex)
      ),
    
      printBoard(FinalBoard).

isEmptyCell(Board, Row, Column, Res, Value) :-
    ((value(Board, Row, Column, Value), Value \== null, Value \== black, Value \== white, !, 
    Res is 1);
    Res is 0).


checkValidSpots(Board, Row, Column, Result) :-
      (
            (Column =:= 11, Row1 is Row + 1, checkValidSpots(Board, Row1, 0, Result));
            (Row =:= 11, Result is 0);
            ((isEmptyCell(Board, Row, Column, Res)), 
                  ((Res =:= 0, Column1 is Column + 1, checkValidSpots(Board, Row, Column1, Result));
                  (Res =:=1 , Result is 1)))
      ), !.



checkMove(Board, Player, NewBoard, ColumnIndex, RowIndex):-
      (
          (Player == white; Player == black),
            (
                       (isEmptyCell(Board, RowIndex, ColumnIndex, ResIsValid, Value),ResIsValid =:= 1),
                        (
                        Value \== empty, % Verifica se jogou em celulas coloridas
                            (replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewNewBoard), 
                            RowIndex1 is 10 - RowIndex, ColumnIndex1 is 10 - ColumnIndex,
                            replaceInMatrix(NewNewBoard, RowIndex1, ColumnIndex1, Player, NewBoard));
                            % Jogada em celula empty
                            replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard)
                        );
            (write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
            move(Board, Player, NewBoard)))).


checkBlackScore(_, 11, 11, Amount) :-
    write('\n Black score: '),
    write(Amount),
    write('\n').

checkBlackScore(Board, ColumnIndex, RowIndex, Amount) :- 
    value(Board, RowIndex, ColumnIndex, Value),
    ColumnIndex1 is ColumnIndex + 1,
    (ColumnIndex1 =:= 11, RowIndex1 is RowIndex + 1, ColumnIndex1 is 0),
    (Value == black, 
    Amount1 is Amount + 1,
    write('black\n'),
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
        write('white\n'),
        checkWhiteScore(Board, ColumnIndex1, RowIndex1, Amount1));
        checkWhiteScore(Board, ColumnIndex1, RowIndex1, Amount)
    ).

    
