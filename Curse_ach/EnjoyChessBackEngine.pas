Unit EnjoyChessBackEngine;

Interface

Uses
    System.Generics.Collections,
    System.Diagnostics,
    SysUtils,
    Classes,
    Graphics,
    ExtCtrls,
    Pngimage;

Type
    { ќбщее дл€ других типов }

    TLocation = Record
        CoordX: 0 .. 8; // 0 - дл€ ходов за пределы доски и отсустви€ на доске
        CoordY: 0 .. 8;
    End;

    { ƒл€ фигур }

    TPiece = Class
    Private
        PiecePosition: TLocation;
        IsLightPiece: Boolean;
        PieceBitmap: TBitmap;
        // Function IsCheck(Position: TLocation): Boolean; Virtual; Abstract;
        // Function IsPossibleMove(Position: TLocation): Boolean; Virtual; Abstract;
    Protected
        Procedure SetBitmap(Value: TBitmap);
        Function GetBitmap(): TBitmap;
        Procedure SetPosition(Value: TLocation);
        Function GetPosition(): TLocation;
        Function GetIsLight(): Boolean;
    Public
        Property Position: TLocation Read GetPosition Write SetPosition;
        Property IsLight: Boolean Read GetIsLight;
        Property PBitmap: TBitmap Read GetBitmap Write SetBitmap;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
            CellSide: Integer); Virtual;
        Destructor Destroy; Override;
    End;

    TKing = Class(TPiece)
    Private
        IsPossibleCastle: Boolean;
        IsCastled: Boolean;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Protected
        Function GetIsPossibleCastle(): Boolean;
        Procedure SetIsPossibleCastle(Value: Boolean);
        Function GetIsCastled(): Boolean;
        Procedure SetIsCastled(Value: Boolean);
    Public
        Property IsPossibleToCastle: Boolean Read GetIsPossibleCastle Write SetIsPossibleCastle;
        Property IsAlreadyCastled: Boolean Read GetIsCastled Write SetIsCastled;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
            CellSide: Integer); Override;
    End;

    TQueen = Class(TPiece)
    Private
        // Function IsCheck(Position: TLocation): Boolean; Override;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
        // Function IsNotFreeDiagonalOrLine(Position: TLocation): Boolean;
    End;

    TBishop = Class(TPiece)
    Private
        // Function IsCheck(Position: TLocation): Boolean; Override;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
        // Function IsNotFreeDiagonal(Position: TLocation): Boolean;
    End;

    TRook = Class(TPiece)
    Private
        // Function IsCheck(Position: TLocation): Boolean; Override;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
        // Function IsNotFreeLine(Position: TLocation): Boolean;
    End;

    TNKnight = Class(TPiece)
        // N поставлена намеренно, т.к. при работе со скинами читаетс€ втора€ буква конкретно этого класса
    Private
        // Function IsCheck(Position: TLocation): Boolean; Override;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
    End;

    TPawn = Class(TPiece)
    Private
        FirstMove: Boolean;
        // Function IsCheck(Position: TLocation): Boolean; Override;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Protected
        Function GetIsFirstMove(): Boolean;
        Procedure SetIsFirstMove(Value: Boolean);
    Public
        Property IsFirstMove: Boolean Read GetIsFirstMove Write SetIsFirstMove;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
            CellSide: Integer); Override;
    End;

    TPListOfPieces = ^TListOfPieces;

    TListOfPieces = Record
        Piece: TPiece;
        Next: TPListOfPieces;
    End;

    { ƒл€ ходов и перемещений }

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

    { ƒл€ клеток доски }

    TBoardCell = Record
        Piece: TPListOfPieces;
        IsLight, IsActive, IsPossibleToMove, IsHighlighted: Boolean;
        CoordX, CoordY: Integer;
    End;

    // TCellProc = Reference To Procedure(Var Cell: TBoardCell);

    TBoard = Array Of Array OF TBoardCell;

    { общий интерфейс между бэком и формой игры }

    TGameState = (Playing, WhiteWin, BlackWin, Draw);

    TChessEngine = Class
    Private
        ExistingPieces: TPListOfPieces;
        TakenWhitePieces: TPListOfPieces;
        TakenBlackPieces: TPListOfPieces;
        FirstMove: Boolean;
        PlayingBoard: TBoard;
        CurrentGameState: TGameState;
        // Sound: TEnjoyChessSound;
    Protected
        Function GetBoard(): TBoard;
        Procedure SetBoard(Value: TBoard);
        Function GetGameState(): TGameState;
        Procedure SetGameState(Value: TGameState);
    Public
        Property Board: TBoard Read GetBoard Write SetBoard;
        Property GameState: TGameState Read GetGameState Write SetGameState;
        // Procedure CheckWinState();
        Procedure InitializeBoard(BoardPaintBox: TPaintBox; CellSide: Integer);
    End;

Implementation

{ ƒл€ фигур }

Constructor TPiece.Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox; CellSide: Integer);
Var
    PieceName: String;
    TempPNG: TPngImage;
Begin
    If IsLightPiece Then
        PieceName := 'w'
    Else
        PieceName := 'b';

    PieceName := PieceName + UpperCase(Copy(ClassName, 2, 1));
    PieceBitmap := TBitmap.Create;
    TempPNG := TPngImage.Create;
    TempPNG.LoadFromFile('skins\chesscom\' + PieceName + '.png');
    PieceBitmap.Assign(TempPNG);
    PieceBitmap.Transparent := True;
    TempPNG.Free;
End;

Procedure TPiece.SetBitmap(Value: TBitmap);
Begin
    PieceBitmap := Value;
End;

Function TPiece.GetBitmap(): TBitmap;
Begin
    GetBitmap := PieceBitmap;
End;

Procedure TPiece.SetPosition(Value: TLocation);
Begin
    PiecePosition := Value;
End;

Function TPiece.GetPosition(): TLocation;
Begin
    GetPosition := PiecePosition;
End;

Function TPiece.GetIsLight(): Boolean;
Begin
    GetIsLight := IsLightPiece;
End;

Destructor TPiece.Destroy;
Begin
    PieceBitmap.Free;
    Inherited;
End;

Constructor TKing.Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox; CellSide: Integer);
Begin
    Inherited Create(Position, IsLightPiece, PBBoard, CellSide);
    IsPossibleCastle := True;
    IsAlreadyCastled := False;
End;

Procedure TKing.SetIsPossibleCastle(Value: Boolean);
Begin
    IsPossibleCastle := Value;
End;

Function TKing.GetIsPossibleCastle(): Boolean;
Begin
    GetIsPossibleCastle := IsPossibleCastle;
End;

Procedure TKing.SetIsCastled(Value: Boolean);
Begin
    IsCastled := Value;
End;

Function TKing.GetIsCastled(): Boolean;
Begin
    GetIsCastled := IsPossibleCastle;
End;

Constructor TPawn.Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox; CellSide: Integer);
Begin
    Inherited Create(Position, IsLightPiece, PBBoard, CellSide);
    FirstMove := True;
End;

Procedure TPawn.SetIsFirstMove(Value: Boolean);
Begin
    FirstMove := Value;
End;

Function TPawn.GetIsFirstMove(): Boolean;
Begin
    GetIsFirstMove := IsFirstMove;
End;

{ дл€ доски }

Procedure TChessEngine.SetBoard(Value: TBoard);
Begin
    PlayingBoard := Value;
End;

Function TChessEngine.GetBoard(): TBoard;
Begin
    GetBoard := PlayingBoard;
End;

Procedure TChessEngine.SetGameState(Value: TGameState);
Begin
    CurrentGameState := Value;
End;

Function TChessEngine.GetGameState(): TGameState;
Begin
    GetGameState := CurrentGameState;
End;

Procedure TChessEngine.InitializeBoard(BoardPaintBox: TPaintBox; CellSide: Integer);
Const
    ROW_COUNT = 8;
    COL_COUNT = 8;
Var
    I, J: Integer;
    TempPos: TLocation;
    PiecePointer: TPListOfPieces;
    TempBoard: TBoard;
Begin
    SetLength(TempBoard, COL_COUNT, ROW_COUNT);

    { задание доски }

    For I := Low(TempBoard) To High(TempBoard) Do
        For J := Low(TempBoard[0]) To High(TempBoard[0]) Do
        Begin
            TempBoard[I, J].CoordX := I;
            TempBoard[I, J].CoordY := J;

            If (I + J) Mod 2 = 0 Then
                TempBoard[I, J].IsLight := False
            Else
                TempBoard[I, J].IsLight := True;

            TempBoard[I, J].IsActive := False;
            TempBoard[I, J].IsPossibleToMove := False;
            TempBoard[I, J].IsHighlighted := False;
        End;

    { задание фигур }

    New(PiecePointer);
    ExistingPieces := PiecePointer;

    // — левого верхнего угла + в массиве board индексаци€ с нул€
    For I := 1 To 8 Do
    Begin
        // черна€ фигура
        TempPos.CoordX := TempBoard[I - 1, 0].CoordX;
        TempPos.CoordY := TempBoard[I - 1, 0].CoordY;

        Case I Of
            1:
                PiecePointer.Piece := TRook.Create(TempPos, False, BoardPaintBox, CellSide);
            2:
                PiecePointer.Piece := TNKnight.Create(TempPos, False, BoardPaintBox, CellSide);
            3:
                PiecePointer.Piece := TBishop.Create(TempPos, False, BoardPaintBox, CellSide);
            4:
                PiecePointer.Piece := TQueen.Create(TempPos, False, BoardPaintBox, CellSide);
            5:
                PiecePointer.Piece := TKing.Create(TempPos, False, BoardPaintBox, CellSide);
            6:
                PiecePointer.Piece := TBishop.Create(TempPos, False, BoardPaintBox, CellSide);
            7:
                PiecePointer.Piece := TNKnight.Create(TempPos, False, BoardPaintBox, CellSide);
            8:
                PiecePointer.Piece := TRook.Create(TempPos, False, BoardPaintBox, CellSide);
        End;

        PiecePointer.Piece.PiecePosition.CoordX := TempPos.CoordX;
        PiecePointer.Piece.PiecePosition.CoordY := TempPos.CoordY;

        TempBoard[I - 1, 0].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;

        // бела€ фигура
        TempPos.CoordX := TempBoard[I - 1, 7].CoordX;
        TempPos.CoordY := TempBoard[I - 1, 7].CoordY;

        Case I Of
            1:
                PiecePointer.Piece := TRook.Create(TempPos, True, BoardPaintBox, CellSide);
            2:
                PiecePointer.Piece := TNKnight.Create(TempPos, True, BoardPaintBox, CellSide);
            3:
                PiecePointer.Piece := TBishop.Create(TempPos, True, BoardPaintBox, CellSide);
            4:
                PiecePointer.Piece := TQueen.Create(TempPos, True, BoardPaintBox, CellSide);
            5:
                PiecePointer.Piece := TKing.Create(TempPos, True, BoardPaintBox, CellSide);
            6:
                PiecePointer.Piece := TBishop.Create(TempPos, True, BoardPaintBox, CellSide);
            7:
                PiecePointer.Piece := TNKnight.Create(TempPos, True, BoardPaintBox, CellSide);
            8:
                PiecePointer.Piece := TRook.Create(TempPos, True, BoardPaintBox, CellSide);
        End;

        PiecePointer.Piece.PiecePosition.CoordX := TempPos.CoordX;
        PiecePointer.Piece.PiecePosition.CoordY := TempPos.CoordY;
        TempBoard[I - 1, 7].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;
    End;

    For I := 1 To 8 Do
    Begin
        // черна€ пешка
        TempPos.CoordX := TempBoard[I - 1, 1].CoordX;
        TempPos.CoordY := TempBoard[I - 1, 1].CoordY;

        PiecePointer.Piece := TPawn.Create(TempPos, False, BoardPaintBox, CellSide);

        PiecePointer.Piece.PiecePosition.CoordX := TempPos.CoordX;
        PiecePointer.Piece.PiecePosition.CoordY := TempPos.CoordY;

        TempBoard[I - 1, 1].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;

        // бела€ пешка
        TempPos.CoordX := TempBoard[I - 1, 6].CoordX;
        TempPos.CoordY := TempBoard[I - 1, 6].CoordY;

        PiecePointer.Piece := TPawn.Create(TempPos, True, BoardPaintBox, CellSide);

        PiecePointer.Piece.PiecePosition.CoordX := TempPos.CoordX;
        PiecePointer.Piece.PiecePosition.CoordY := TempPos.CoordY;

        TempBoard[I - 1, 6].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;
    End;

    SetBoard(TempBoard);
    PiecePointer^.Next := Nil;

    CurrentGameState := Playing;
    FirstMove := True;
End;

End.
