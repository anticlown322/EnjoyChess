Unit EnjoyChessBackEngine;

Interface

Uses
    System.Generics.Collections,
    System.Diagnostics;

Type
    { Общее }

    TLocation = Record
        CoordX: 0 .. 8;   // 0 - для ходов за пределы доски и отсуствия на доске
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
        // FigureID: Byte;
        //Function IsCheck(Position: TLocation): Boolean; Virtual; Abstract;
        //Function IsPossibleMove(Position: TLocation): Boolean; Virtual; Abstract;
        //Procedure MoveFigure(Position: TLocation); Virtual;
    Public
        Property Position: TLocation Read FigurePosition;
        Property IsLight: Boolean Read IsLightPiece;

//        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Virtual;
//        Destructor Destroy; Override;
    End;

    TKing = Class(TPiece)
    Private
        IsPossibleCastle: Boolean;
        IsAlreadyCastled: Boolean;
        //Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Public
        //Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
    End;

    TQueen = Class(TPiece)
    Private
//        Function IsCheck(Position: TLocation): Boolean; Override;
//        Function IsPossibleMove(Position: TLocation): Boolean; Override;
//        Function IsNotFreeDiagonalOrLine(Position: TLocation): Boolean;
    End;

    TBishop = Class(TPiece)
    Private
//        Function IsCheck(Position: TLocation): Boolean; Override;
//        Function IsPossibleMove(Position: TLocation): Boolean; Override;
//        Function IsNotFreeDiagonal(Position: TLocation): Boolean;
    End;

    TRook = Class(TPiece)
    Private
//        Function IsCheck(Position: TLocation): Boolean; Override;
//        Function IsPossibleMove(Position: TLocation): Boolean; Override;
//        Function IsNotFreeLine(Position: TLocation): Boolean;
    End;

    TKnight = Class(TPiece)
    Private
//        Function IsCheck(Position: TLocation): Boolean; Override;
//        Function IsPossibleMove(Position: TLocation): Boolean; Override;
    End;

    TPawn = Class(TPiece)
    Private
        FirstStep: Boolean;
//        Function IsCheck(Position: TLocation): Boolean; Override;
//        Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Public
//        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
    End;

    TPListOfPieces = ^TListOfPieces;

    TListOfPieces = Record
        Piece: TPiece;
        Next: TPListOfPieces;
    End;

    { Для ходов и перемещений }

    TPChange = ^TChange;

    TChange = Record
        Piece: TPiece;
        Source: TLocation;
        Dest: TLocation;
    End;

    TMoveType = (TNormal, TEnPassant, TCastling, TPawnPromote);

    TPMove = ^TMove;

    TMove = Record
        Change: TChange;
        Capture: Boolean;
        Contents: TPiece;
        Next: TPMove;
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
        TakenWhitePieces: TPListOfPieces;
        TakenBlackPieces: TPListOfPieces;
        FirstMove: Boolean;
        // Procedure CheckWinState();
    Protected
//        Procedure FindPossibleMovesOfPiece();
//        Procedure ForEveryCell(CellProc: TCellProc);
    Public
        Board: TBoard;
        GameState: TGameState;
        // Sound: TEnjoyChessSound;
        Procedure InitializeBoard();
//        Constructor Create;
    End;

Implementation

Procedure TChessEngine.InitializeBoard();
Const
    ROW_COUNT = 8;
    COL_COUNT = 8;
Var
    I, J: Integer;
Begin
    SetLength(Board, COL_COUNT, ROW_COUNT);

    For I := Low(Board) To High(Board) Do
        For J := Low(Board[0]) To High(Board[0]) Do
        Begin
            Board[I, J].CoordX := I;
            Board[I, J].CoordY := J;

            If (I + J) Mod 2 = 0 Then
                Board[I, J].IsLight := False
            Else
                Board[I, J].IsLight := True;
        End;

    GameState := Playing;
    FirstMove := True;
End;

End.
