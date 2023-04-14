Unit EnjoyChessBackEngine;

Interface

Type
    { Общее }

    TLocation = Record
        CoordX: 0 .. 8;
        CoordY: 0 .. 8;
    End;

    { Для клеток доски }

    TBoardCell = Record
    Public
        IsLight: Boolean;
        CoordX, CoordY: Integer;
    End;

    TCellProc = Reference To Procedure(Var Cell: TBoardCell);

    TBoard = Array Of Array OF TBoardCell;

    { Для фигур }

    TPiece = Class
    Private
        FigurePosition: TLocation;
        IsLightPiece: Boolean;
        //FigureID: Byte;
        Function IsCheck(Position: TLocation): Boolean; Virtual; Abstract;
        Function IsPossibleMove(Position: TLocation): Boolean; Virtual; Abstract;
        Procedure MoveFigure(Position: TLocation); Virtual;
    Public
        Property Position: TLocation Read FigurePosition;
        Property IsLight: Boolean Read IsLightPiece;

        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Virtual;
        Destructor Destroy; Override;
    End;

    TKing = Class(TPiece)
    Private
        IsPossibleCastle: Boolean;
        IsAlreadyCastled: Boolean;
        Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Public
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
    End;

    TQueen = Class(TPiece)
    Private
        Function IsCheck(Position: TLocation): Boolean; Override;
        Function IsPossibleMove(Position: TLocation): Boolean; Override;
        Function IsNotFreeDiagonalOrLine(Position: TLocation): Boolean;
    End;

    TBishop = Class(TPiece)
    Private
        Function IsCheck(Position: TLocation): Boolean; Override;
        Function IsPossibleMove(Position: TLocation): Boolean; Override;
        Function IsNotFreeDiagonal(Position: TLocation): Boolean;
    End;

    TRook = Class(TPiece)
    Private
        Function IsCheck(Position: TLocation): Boolean; Override;
        Function IsPossibleMove(Position: TLocation): Boolean; Override;
        Function IsNotFreeLine(Position: TLocation): Boolean;
    End;

    TKnight = Class(TPiece)
    Private
        Function IsCheck(Position: TLocation): Boolean; Override;
        Function IsPossibleMove(Position: TLocation): Boolean; Override;
    End;

    TPawn = Class(TPiece)
    Private
        FirstStep: Boolean;
        Function IsCheck(Position: TLocation): Boolean; Override;
        Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Public
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
    End;

    { Для ходов и перемещений }

    PChange = ^TChange;

    TChange = Record
        Piece: TPiece;
        Source: TLocation;
        Dest: TLocation;
    End;

    TMoveType = (TNormal, TEnPassant, TCastling, TPawnPromote);

    PMove = ^TMove;

    TMove = Record
        Change: TChange;
        Capture: Boolean;
        Contents: TPiece;
    Case Kind: TMoveType Of
            TEnPassant:
                (EPCapture: TLocation);
            TCastling:
                (RookSource, RookDest: TLocation);
    End;

    { Класс бэковго движка, обеспечивающего связь. Типа интерфейс между бэком и формой игры }

    TGameState = (Playing, WhiteWin, BlackWin, Draw);

    TChessEngine = Class
    Private
        FirstMove: Boolean;
        Procedure CheckWinState();
        // proc CheckValid();
    Protected
        Procedure FindPossibleMovesOfPiece();
        Procedure ForEveryCell(CellProc: TCellProc);

    Public
        Board: TBoard;
        GameState: TGameState;
        // Sound: TEnjoyChessSound;
        Procedure InitializeBoard();
    End;

Implementation

End.
