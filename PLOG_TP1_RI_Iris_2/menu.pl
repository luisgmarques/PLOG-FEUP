mainMenu :-
    printMainMenu,
    askMenuOption,
    read(Input),
    manageInput(Input).

manageInput(1) :-
    startGame('P','P'),
    mainMenu.

manageInput(2) :-
    startGame('P','C'),
    mainMenu.

manageInput(3) :-
    startGame('C','C'),
    mainMenu.
    
manageInput(0) :-
    write('\nExiting...\n\n').

manageInput(_) :-
    write('\nERROR: that option does not exist.\n\n'),
    askMenuOption,
    read(Input),
    manageInput(Input).

printMainMenu :-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                         __   _____   __   _____                       |'),nl,
    write('|                        |  | |  _  | |  | |  ___|                      |'),nl,
    write('|                        |  | | |_| | |  | |  |__                       |'),nl,
    write('|                        |  | |  _ |  |  |  |__  |                      |'),nl,
    write('|                        |__| |_| |_| |__| |_____|                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                              Luis Marques                             |'),nl,
    write('|                              Joao Barros                              |'),nl,
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player vs Player                          |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player vs Computer                        |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Computer vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write(' _______________________________________________________________________ '),nl,nl,nl.

askMenuOption :-
    write('> Insert option ').