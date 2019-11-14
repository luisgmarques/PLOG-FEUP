askCoords(Board, Player, NewBoard) :-
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

checkGameState(Player, Board) :-
    checkFullBoard(Board),
    write('\nend\n').

printComputerMove(NewRowIndex, NewColumnIndex):-
      NewRow is NewRowIndex + 1,
      NewColumn is NewColumnIndex + 1,
      letter(NewRow, RowLetter),
      write(' > Computer added a piece in the cell [row: '), write(RowLetter), write(' column: '), write(NewColumn), write(']\n').

startGame(Player1, Player2) :-
    emptyBoard(InitialBoard),
    gameLoop(InitialBoard, Player1, Player2).



gameLoop(Board, Player1, Player2) :-
      blackPlayerTurn(Board, NewBoard, Player1),
      (
            (checkGameState('black', NewBoard), write('\nThanks for playing!\n'));
            (whitePlayerTurn(NewBoard, FinalBoard, Player2),
                  (
                        (checkGameState('white', FinalBoard), write('\nThanks for playing!\n'));
                        (gameLoop(FinalBoard, Player1, Player2))
                  )
            )
      ).

blackPlayerTurn(Board, NewBoard, 'P') :-
    printBoard(Board),
    write('\n--------------------- PLAYER [b]lack ------------------------\n.\n'),
    askCoords(Board, black, NewBoard),
    printBoard(NewBoard).

blackPlayerTurn(Board, NewBoard, 'C') :-
      write('\n------------------- COMPUTER [b]lack --------------------\n\n'),
      generatePlayerMove(Board, NewRowIndex, NewColumnIndex, Value),
      printComputerPlayBlack(Board, NewRowIndex, NewColumnIndex, NewBoard, Value).

printComputerPlayBlack(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value) :-
    (Value \= empty, !,
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
      askCoords(NewBoard, white, FinalBoard),
      printBoard(FinalBoard).

whitePlayerTurn(Board, FinalBoard, 'C') :-
       write('\n------------------- COMPUTER [w]hite --------------------\n\n'),
       generatePlayerMove(Board, NewRowIndex, NewColumnIndex, Value),
       printComputerPlayWhite(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value), sleep(1).


printComputerPlayWhite(Board, NewRowIndex, NewColumnIndex, FinalBoard, Value) :-
    (Value \= empty, !,
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
    ((getValueFromMatrix(Board, Row, Column, Value), Value \= null, Value \= black, Value \= white, !, 
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
                        Value \= empty, % Verifica se jogou em celulas coloridas
                            (replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewNewBoard), 
                            RowIndex1 is 10 - RowIndex, ColumnIndex1 is 10 - ColumnIndex,
                            replaceInMatrix(NewNewBoard, RowIndex1, ColumnIndex1, Player, NewBoard));
                            replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard)
                        );
            (write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
            askCoords(Board, Player, NewBoard)))).