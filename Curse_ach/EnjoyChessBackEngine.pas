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
        CoordRow: 0 .. 8; // 8 - дл€ ходов за пределы доски и отсустви€ на доске
        CoordCol: 0 .. 8;
    End;

    TPiece = Class;

    { ƒл€ клеток доски }

    TPListOfPieces = ^TListOfPieces;

    TListOfPieces = Record
        Piece: TPiece;
        Next: TPListOfPieces;
    End;

    TBoardCell = Record
        PPiece: TPListOfPieces;
        IsLight, IsActive, IsPossibleToMove, IsHighlighted: Boolean;
        CoordRow, CoordCol: Integer;
    End;

    TBoard = Array Of Array OF TBoardCell;

    { дл€ всех фигур }

    TPPossibleMoves = ^TPossibleMoves;

    TPossibleMoves = Record
        PossibleMove: TLocation;
        Next: TPPossibleMoves;
    End;

    TPiece = Class
    Private
        PiecePosition: TLocation;
        IsLightPiece: Boolean;
        PieceBitmap: TBitmap;
    Protected
        Procedure SetBitmap(Value: TBitmap);
        Function GetBitmap(): TBitmap;
        Procedure SetPosition(Value: TLocation);
        Function GetPosition(): TLocation;
        Function GetIsLight(): Boolean;
    Public
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Virtual; Abstract;
        Property Position: TLocation Read GetPosition Write SetPosition;
        Property IsLight: Boolean Read GetIsLight;
        Property PBitmap: TBitmap Read GetBitmap Write SetBitmap;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Virtual;
        Destructor Destroy; Override;
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

    { сами фигуры }

    TKing = Class(TPiece)
    Private
        IsPossibleCastle: Boolean;
        IsCastled: Boolean;
    Protected
        Function GetIsPossibleCastle(): Boolean;
        Procedure SetIsPossibleCastle(Value: Boolean);
        Function GetIsCastled(): Boolean;
        Procedure SetIsCastled(Value: Boolean);
    Public
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Override;
        Property IsPossibleToCastle: Boolean Read GetIsPossibleCastle Write SetIsPossibleCastle;
        Property IsAlreadyCastled: Boolean Read GetIsCastled Write SetIsCastled;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
    End;

    TQueen = Class(TPiece)
    Public
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Override;
    End;

    TBishop = Class(TPiece)
    Public
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Override;
    End;

    TRook = Class(TPiece)
    Public
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Override;
    End;

    TNKnight = Class(TPiece)
        // N поставлена намеренно, т.к. при работе со скинами читаетс€ втора€ буква конкретно этого класса
    Public
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Override;
    End;

    TPawn = Class(TPiece)
    Private
        FirstMove: Boolean;
    Protected
        Function GetIsFirstMove(): Boolean;
        Procedure SetIsFirstMove(Value: Boolean);
    Public
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Override;
        Property IsFirstMove: Boolean Read GetIsFirstMove Write SetIsFirstMove;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
    End;

    { общий интерфейс между бэком и формой игры }

    TGameState = (Playing, WhiteWin, BlackWin, Draw);

    TChessEngine = Class
    Private
        ExistingPieces: TPListOfPieces;
        TakenWhitePieces: TPListOfPieces;
        TakenBlackPieces: TPListOfPieces;
        PlayingBoard: TBoard;
        CurrentGameState: TGameState;
        // Sound: TEnjoyChessSound;
    Protected
        Function GetListOfPieces(): TPListOfPieces;
        Procedure SetListOfPieces(Value: TPListOfPieces);
        Function GetListOfTakenBPieces(): TPListOfPieces;
        Procedure SetListOfTakenBPieces(Value: TPListOfPieces);
        Function GetListOfTakenWPieces(): TPListOfPieces;
        Procedure SetListOfTakenWPieces(Value: TPListOfPieces);
        Function GetBoard(): TBoard;
        Procedure SetBoard(Value: TBoard);
        Function GetGameState(): TGameState;
        Procedure SetGameState(Value: TGameState);
    Public
        Property Board: TBoard Read GetBoard Write SetBoard;
        Property GameState: TGameState Read GetGameState Write SetGameState;
        Property ListOfPieces: TPListOfPieces Read GetListOfPieces Write SetListOfPieces;
        Property TakenWhite: TPListOfPieces Read GetListOfTakenWPieces Write SetListOfTakenWPieces;
        Property TakenBlack: TPListOfPieces Read GetListOfTakenBPieces Write SetListOfTakenBPieces;
        // Procedure CheckWinState();
        Procedure InitializeBoard();
    End;

Implementation

{ ƒл€ фигур }

Constructor TPiece.Create(Position: TLocation; IsLightPiece: Boolean);
Var
    PieceName: String;
    TempPNG: TPngImage;
Begin
    If IsLightPiece Then
        PieceName := 'w'
    Else
        PieceName := 'b';

    SetPosition(Position);

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

Constructor TKing.Create(Position: TLocation; IsLightPiece: Boolean);
Begin
    Inherited Create(Position, IsLightPiece);
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

Constructor TPawn.Create(Position: TLocation; IsLightPiece: Boolean);
Begin
    Inherited Create(Position, IsLightPiece);
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

Procedure TChessEngine.SetListOfPieces(Value: TPListOfPieces);
Begin
    ExistingPieces := Value;
End;

Function TChessEngine.GetListOfPieces(): TPListOfPieces;
Begin
    GetListOfPieces := ExistingPieces;
End;

Procedure TChessEngine.SetListOfTakenBPieces(Value: TPListOfPieces);
Begin
    TakenBlack := Value;
End;

Function TChessEngine.GetListOfTakenBPieces(): TPListOfPieces;
Begin
    GetListOfTakenBPieces := TakenBlack;
End;

Procedure TChessEngine.SetListOfTakenWPieces(Value: TPListOfPieces);
Begin
    TakenWhite := Value;
End;

Function TChessEngine.GetListOfTakenWPieces(): TPListOfPieces;
Begin
    GetListOfTakenWPieces := TakenWhite;
End;

Procedure TChessEngine.InitializeBoard();
Const
    ROW_COUNT = 8;
    COL_COUNT = 8;
Var
    I, J: Integer;
    TempPos: TLocation;
    PointerPiece: TPListOfPieces;
    TempBoard: TBoard;
Begin
    SetLength(TempBoard, ROW_COUNT, COL_COUNT);

    { задание доски }

    For I := Low(TempBoard) To High(TempBoard) Do
        For J := Low(TempBoard[0]) To High(TempBoard[0]) Do
        Begin
            TempBoard[I, J].CoordRow := I;
            TempBoard[I, J].CoordCol := J;

            If (I + J) Mod 2 = 0 Then
                TempBoard[I, J].IsLight := False
            Else
                TempBoard[I, J].IsLight := True;

            TempBoard[I, J].IsActive := False;
            TempBoard[I, J].IsPossibleToMove := False;
            TempBoard[I, J].IsHighlighted := False;
        End;

    { задание фигур }

    New(PointerPiece);
    ExistingPieces := PointerPiece;

    // — левого верхнего угла + в массиве board индексаци€ с нул€
    For I := 1 To 8 Do
    Begin
        // черна€ фигура
        TempPos.CoordRow := 0;
        TempPos.CoordCol := I - 1;

        Case I Of
            1:
                PointerPiece.Piece := TRook.Create(TempPos, False);
            2:
                PointerPiece.Piece := TNKnight.Create(TempPos, False);
            3:
                PointerPiece.Piece := TBishop.Create(TempPos, False);
            4:
                PointerPiece.Piece := TQueen.Create(TempPos, False);
            5:
                PointerPiece.Piece := TKing.Create(TempPos, False);
            6:
                PointerPiece.Piece := TBishop.Create(TempPos, False);
            7:
                PointerPiece.Piece := TNKnight.Create(TempPos, False);
            8:
                PointerPiece.Piece := TRook.Create(TempPos, False);
        End;

        TempBoard[0, I - 1].PPiece := PointerPiece;

        New(PointerPiece^.Next);
        PointerPiece := PointerPiece^.Next;
    End;

    For I := 1 To 8 Do
    Begin
        // черна€ пешка
        TempPos.CoordRow := 1;
        TempPos.CoordCol := I - 1;

        PointerPiece.Piece := TPawn.Create(TempPos, False);

        TempBoard[1, I - 1].PPiece := PointerPiece;

        New(PointerPiece^.Next);
        PointerPiece := PointerPiece^.Next;
    End;

    For I := 1 To 8 Do
    Begin
        // бела€ пешка
        TempPos.CoordRow := 6;
        TempPos.CoordCol := I - 1;

        PointerPiece.Piece := TPawn.Create(TempPos, True);

        TempBoard[6, I - 1].PPiece := PointerPiece;

        New(PointerPiece^.Next);
        PointerPiece := PointerPiece^.Next;
    End;

    For I := 1 To 8 Do
    Begin
        // бела€ фигура
        TempPos.CoordRow := 7;
        TempPos.CoordCol := I - 1;

        Case I Of
            1:
                PointerPiece.Piece := TRook.Create(TempPos, True);
            2:
                PointerPiece.Piece := TNKnight.Create(TempPos, True);
            3:
                PointerPiece.Piece := TBishop.Create(TempPos, True);
            4:
                PointerPiece.Piece := TQueen.Create(TempPos, True);
            5:
                PointerPiece.Piece := TKing.Create(TempPos, True);
            6:
                PointerPiece.Piece := TBishop.Create(TempPos, True);
            7:
                PointerPiece.Piece := TNKnight.Create(TempPos, True);
            8:
                PointerPiece.Piece := TRook.Create(TempPos, True);
        End;

        TempBoard[7, I - 1].PPiece := PointerPiece;

        New(PointerPiece^.Next);
        PointerPiece := PointerPiece^.Next;
    End;

    PointerPiece^.Next := Nil;

    SetBoard(TempBoard);
    CurrentGameState := Playing;
End;

{ дл€ ходов }

Function TKing.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    I, J: Integer;
    ListOfPossibleMoves, PointerMove: TPPossibleMoves;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;

    For I := Position.CoordRow - 1 To Position.CoordRow + 1 Do
        For J := Position.CoordCol - 1 To Position.CoordCol + 1 Do
        Begin
            If ((I > 0) And (I < 7) And (J > 0) And (J < 7)) And
                ((I <> Position.CoordCol) And (J <> Position.CoordRow)) Then
            Begin
                If Board[I, J].PPiece = Nil Then
                Begin
                    PointerMove.PossibleMove.CoordRow := I;
                    PointerMove.PossibleMove.CoordCol := J;

                    New(PointerMove^.Next);
                    PointerMove := PointerMove^.Next;
                End;
            End;
        End;

    PointerMove^.Next := Nil;
    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TQueen.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    I, J: Integer;
    ListOfPossibleMoves, PointerMove: TPPossibleMoves;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;

    For I := 0 To 7 Do
        For J := 0 To 7 Do
        Begin
            If (I <> Position.CoordCol) And (J <> Position.CoordRow) Then
            Begin
                If Board[I, J].PPiece = Nil Then
                Begin
                    PointerMove.PossibleMove.CoordRow := I;
                    PointerMove.PossibleMove.CoordCol := J;

                    New(PointerMove^.Next);
                    PointerMove := PointerMove^.Next;
                End;
            End;
        End;

    PointerMove^.Next := Nil;
    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TRook.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    I, J: Integer;
    ListOfPossibleMoves, PointerMove: TPPossibleMoves;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;

    For I := 0 To 7 Do
        For J := 0 To 7 Do
        Begin
            If (I <> Position.CoordCol) And (J <> Position.CoordRow) Then
            Begin
                If Board[I, J].PPiece = Nil Then
                Begin
                    PointerMove.PossibleMove.CoordRow := I;
                    PointerMove.PossibleMove.CoordCol := J;

                    New(PointerMove^.Next);
                    PointerMove := PointerMove^.Next;
                End;
            End;
        End;

    PointerMove^.Next := Nil;
    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TBishop.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    I, J: Integer;
    ListOfPossibleMoves, PointerMove: TPPossibleMoves;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;

    For I := 0 To 7 Do
        For J := 0 To 7 Do
        Begin
            If (I <> Position.CoordCol) And (J <> Position.CoordRow) Then
            Begin
                If Board[I, J].PPiece = Nil Then
                Begin
                    PointerMove.PossibleMove.CoordRow := I;
                    PointerMove.PossibleMove.CoordCol := J;

                    New(PointerMove^.Next);
                    PointerMove := PointerMove^.Next;
                End;
            End;
        End;

    PointerMove^.Next := Nil;
    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TNKnight.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    I, J: Integer;
    ListOfPossibleMoves, PointerMove: TPPossibleMoves;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;

    For I := Position.CoordRow - 2 To Position.CoordRow + 2 Do
        For J := Position.CoordCol - 2 To Position.CoordCol + 2 Do
        Begin
            If ((I > 0) And (I < 7) And (J > 0) And (J < 7)) And
                ((I <> Position.CoordCol) And (J <> Position.CoordRow)) Then
            Begin
                If Board[I, J].PPiece = Nil Then
                Begin
                    PointerMove.PossibleMove.CoordRow := I;
                    PointerMove.PossibleMove.CoordCol := J;

                    New(PointerMove^.Next);
                    PointerMove := PointerMove^.Next;
                End;
            End;
        End;

    PointerMove^.Next := Nil;
    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TPawn.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    I: Integer;
    ListOfPossibleMoves, PointerMove: TPPossibleMoves;
    Color: Boolean;
Begin
    Color := GetIsLight;

    If Color Then
    Begin
        For I := Position.CoordRow - 1 DownTo Position.CoordRow - 2 Do
        Begin
            If ((I > -1) And (I < 8) And (Position.CoordCol > -1) And (Position.CoordCol < 8)) Then
            Begin
                If Board[I, Position.CoordCol].PPiece = Nil Then
                Begin
                    New(PointerMove);
                    PointerMove^.PossibleMove.CoordRow := I;
                    PointerMove^.PossibleMove.CoordCol := Position.CoordCol;

                    PointerMove^.Next := ListOfPossibleMoves;
                    ListOfPossibleMoves := PointerMove;
                End;
            End;
        End;
    End
    Else
    Begin
        For I := Position.CoordRow + 1 To Position.CoordRow + 2 Do
        Begin
            If ((I > -1) And (I < 8) And (Position.CoordCol > -1) And (Position.CoordCol < 8)) Then
            Begin
                If Board[I, Position.CoordCol].PPiece = Nil Then
                Begin
                    New(PointerMove);
                    PointerMove^.PossibleMove.CoordRow := I;
                    PointerMove^.PossibleMove.CoordCol := Position.CoordCol;

                    PointerMove^.Next := ListOfPossibleMoves;
                    ListOfPossibleMoves := PointerMove;
                End;
            End;
        End;
    End;

    ListOfPossibleMoves^.Next^.Next := nil;
    FindPossibleMoves := ListOfPossibleMoves;
End;

End.
