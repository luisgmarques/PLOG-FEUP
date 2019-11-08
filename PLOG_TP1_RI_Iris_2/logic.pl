askCoords(Board, Player, NewBoard, Expected) :-
    manageRow(NewRow),
    manageColumn(NewColumn),
    write('\n'),
    ColumnIndex is NewColumn - 1,
    RowIndex is NewRow - 1,
    checkMove(Board, Player, NewBoard, Expected, ColumnIndex, RowIndex).



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
    write('\n------------------ PLAYER 1 -------------------\n\n'),
    askCoords(Board, black, NewBoard, empty),
    printBoard(NewBoard).

whitePlayerTurn(NewBoard, FinalBoard, 'P') :-
printBoard(Board),
      write('\n------------------ PLAYER 2 -------------------\n\n'),
      askCoords(Board, white, FinalBoard, empty),
      printBoard(FinalBoard).

isEmptyCell(Board, Row, Column, Res) :-
    ((getValueFromMatrix(Board, Row, Column, Value), Value == empty, !, 
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



checkMove(Board, Player, NewBoard, Expected, ColumnIndex, RowIndex):-
      (
          (Player == white; Player == black),
            (
                (getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
                   (
                       (isEmptyCell(Board, RowIndex, ColumnIndex, ResIsValidP), ResIsValid =:= 1),
                        replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard);
            (write('INVALID MOVE: That cell is not empty, please try again!\n\n'),
            askCoords(Board, Player, NewBoard, Expected)))))).







/*
play(Game) :-
    initialize(Game, Position, Player),
    display_game(Position, Player),
    play(Position, Player, Result).

play(Position, Player, Result) :-
    game_over(Position, Player, Result).

play(Position, Player, Result) :-
    choose_move(Position, Player, Move),
    move(Move, Position, Position1),
    display_game(Position1, Player),
    !, play(Position1, Player1, Result).

/** choose best move **/

/*
choose_move(Position, computer, Move) :-
    findall(M, move(Position, M), Moves),
    evaluate_and_choose(Moves, Position, ([], -1000), Move).

evaluate_and_choose([Move|Moves], Position, Record, BestMove) :-
    move(Move, Position, Position1),
    value(Position1, Value),
    update(Move, Value, Record, Record1),
    evaluate_and_choose(Moves, Position, Record1, BestMove).
evaluate_and_choose([], Position, (Move, Value), Move).

update(Move, Value, (Move1, Value1), (Move1, Value1)) :-
    Value <= Value1.
update(Move, Value, (Move1, Value1), (Move, Value)) :-
    Value > Value1.

    */