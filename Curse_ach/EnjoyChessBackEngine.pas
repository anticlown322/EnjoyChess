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
    { Общее для других типов }

    TLocation = Record
        CoordRow: 0 .. 7;
        CoordCol: 0 .. 7;
    End;

    TChessEngine = Class;
    TPiece = Class;

    { Для клеток доски }

    TPListOfPieces = ^TListOfPieces;

    TListOfPieces = Record
        Piece: TPiece;
        Next: TPListOfPieces;
    End;

    TBoardCell = Record
        PPiece: TPListOfPieces;
        IsLight, IsActive, IsPossibleToMove, IsHighlighted, IsTake: Boolean;
        CoordRow, CoordCol: Integer;
    End;

    TBoard = Array Of Array OF TBoardCell;

    { Для ходов и перемещений }

    TMoveType = (TNormal, TEnPassant, TCastling, TPawnPromote);

    TPMove = ^TMove;

    TMove = Record
        Piece: TPiece;
        Source: TLocation;
        Dest: TLocation;
        Capture: Boolean;
        Next: TPMove;
        Case Kind: TMoveType Of
            TEnPassant:
                (EPCapture: TLocation);
            TCastling:
                (RookSource, RookDest: TLocation);
    End;

    { для всех фигур }

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
        Procedure SetIsLight(Value: Boolean);
        Function GetIsLight(): Boolean;
    Public
        Function MakeMove(Board: TBoard; Dest: TLocation; Var IsWhiteTurn: Boolean): TPMove; Virtual;
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Virtual; Abstract;
        Property Position: TLocation Read GetPosition Write SetPosition;
        Property IsLight: Boolean Read GetIsLight Write SetIsLight;
        Property PBitmap: TBitmap Read GetBitmap Write SetBitmap;
        Constructor Create(Position: TLocation; IsPieceLight: Boolean); Virtual;
        Destructor Destroy; Override;
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
        Function MakeMove(Board: TBoard; Dest: TLocation; Var IsWhiteTurn: Boolean): TPMove; Override;
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
        // N поставлена намеренно, т.к. при работе со скинами читается вторая буква класса
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
        Function MakeMove(Board: TBoard; Dest: TLocation; Var IsWhiteTurn: Boolean): TPMove; Override;
        Function FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves; Override;
        Procedure SearchPawnMoves(Position: TLocation; Board: TBoard; Var TempPointer, PointerMove: TPPossibleMoves;
            Var MovesExist: Boolean);
        Property IsFirstMove: Boolean Read GetIsFirstMove Write SetIsFirstMove;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
    End;

    { интерфейс между этим юнитом и формой }

    TGameState = (Playing, WhiteWin, BlackWin, Draw);

    TChessEngine = Class
    Private
        ExistingPieces: TPListOfPieces;
        TakenWhitePieces: TPListOfPieces;
        TakenBlackPieces: TPListOfPieces;
        PlayingBoard: TBoard;
        CurrentGameState: TGameState;
        MakedMoves: TPMove;
        IsLightTurn: Boolean;
        IsKingChecked: Boolean;
        PWhiteKing: TPListOfPieces;
        PBlackKing: TPListOfPieces;
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
        Function GetListOfMoves(): TPMove;
        Procedure SetListOfMoves(Value: TPMove);
        Function GetIsWhiteTurn(): Boolean;
        Procedure SetIsWhiteTurn(Value: Boolean);
        Function GetIsCheck(): Boolean;
        Procedure SetIsCheck(Value: Boolean);
        Function GetWhiteKingPointer(): TPListOfPieces;
        Procedure SetWhiteKingPointer(Value: TPListOfPieces);
        Function GetBlackKingPointer(): TPListOfPieces;
        Procedure SetBlackKingPointer(Value: TPListOfPieces);
    Public
        Property Board: TBoard Read GetBoard Write SetBoard;
        Property GameState: TGameState Read GetGameState Write SetGameState;
        Property ListOfPieces: TPListOfPieces Read GetListOfPieces Write SetListOfPieces;
        Property TakenWhite: TPListOfPieces Read GetListOfTakenWPieces Write SetListOfTakenWPieces;
        Property TakenBlack: TPListOfPieces Read GetListOfTakenBPieces Write SetListOfTakenBPieces;
        Property ListOfMoves: TPMove Read GetListOfMoves Write SetListOfMoves;
        Property IsWhiteTurn: Boolean Read GetIsWhiteTurn Write SetIsWhiteTurn;
        Property IsCheck: Boolean Read GetIsCheck Write SetIsCheck;
        Property WhiteKing: TPListOfPieces Read GetWhiteKingPointer Write SetWhiteKingPointer;
        Property BlackKing: TPListOfPieces Read GetBlackKingPointer Write SetBlackKingPointer;
        Procedure InitializeBoard();
        Function FindIsCheck(Board: TBoard; King: TPListOfPieces): Boolean;
    End;

Implementation

{ Для фигур }

Constructor TPiece.Create(Position: TLocation; IsPieceLight: Boolean);
Var
    PieceName: String;
    TempPNG: TPngImage;
Begin
    If IsPieceLight Then
        PieceName := 'w'
    Else
        PieceName := 'b';

    SetPosition(Position);
    SetIsLight(IsPieceLight);

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

Procedure TPiece.SetIsLight(Value: Boolean);
Begin
    IsLightPiece := Value;
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
    GetIsFirstMove := FirstMove;
End;

{ для доски }

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

Procedure TChessEngine.SetListOfMoves(Value: TPMove);
Begin
    MakedMoves := Value;
End;

Function TChessEngine.GetListOfMoves(): TPMove;
Begin
    GetListOfMoves := MakedMoves;
End;

Procedure TChessEngine.SetIsWhiteTurn(Value: Boolean);
Begin
    IsLightTurn := Value;
End;

Function TChessEngine.GetIsWhiteTurn(): Boolean;
Begin
    GetIsWhiteTurn := IsLightTurn;
End;

Procedure TChessEngine.SetIsCheck(Value: Boolean);
Begin
    IsKingChecked := Value;
End;

Function TChessEngine.GetIsCheck(): Boolean;
Begin
    GetIsCheck := IsKingChecked;
End;

Procedure TChessEngine.SetWhiteKingPointer(Value: TPListOfPieces);
Begin
    PWhiteKing := Value;
End;

Function TChessEngine.GetWhiteKingPointer(): TPListOfPieces;
Begin
    GetWhiteKingPointer := PWhiteKing;
End;

Procedure TChessEngine.SetBlackKingPointer(Value: TPListOfPieces);
Begin
    PBlackKing := Value;
End;

Function TChessEngine.GetBlackKingPointer(): TPListOfPieces;
Begin
    GetBlackKingPointer := PBlackKing;
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
            TempBoard[I, J].IsTake := False;
        End;

    { задание фигур }

    New(PointerPiece);
    ExistingPieces := PointerPiece;

    For I := 1 To 8 Do
    Begin
        // черная фигура
        TempPos.CoordRow := 0; // С левого верхнего угла + в массиве board индексация с нуля
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
                Begin
                    PointerPiece.Piece := TKing.Create(TempPos, False);
                    BlackKing := PointerPiece;
                End;
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
        // черная пешка
        TempPos.CoordRow := 1;
        TempPos.CoordCol := I - 1;

        PointerPiece.Piece := TPawn.Create(TempPos, False);

        TempBoard[1, I - 1].PPiece := PointerPiece;

        New(PointerPiece^.Next);
        PointerPiece := PointerPiece^.Next;
    End;

    For I := 1 To 8 Do
    Begin
        // белая пешка
        TempPos.CoordRow := 6;
        TempPos.CoordCol := I - 1;

        PointerPiece.Piece := TPawn.Create(TempPos, True);

        TempBoard[6, I - 1].PPiece := PointerPiece;

        New(PointerPiece^.Next);
        PointerPiece := PointerPiece^.Next;
    End;

    For I := 1 To 8 Do
    Begin
        // белая фигура
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
                Begin
                    PointerPiece.Piece := TKing.Create(TempPos, True);
                    WhiteKing := PointerPiece;
                End;
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

{ для ходов }

Procedure Iteration(Var TempPointer, PointerMove: TPPossibleMoves; Const Row, Col: Integer; Var MovesExist: Boolean);
Begin
    TempPointer := PointerMove;
    PointerMove^.PossibleMove.CoordRow := Row;
    PointerMove^.PossibleMove.CoordCol := Col;
    New(PointerMove);
    TempPointer^.Next := PointerMove;
    MovesExist := True;
End;

Procedure SearchKingMoves(Position: TLocation; Board: TBoard; Var TempPointer, PointerMove: TPPossibleMoves;
    Var MovesExist: Boolean);
Var
    I, J: Integer;
    TempPiece: TPiece;
Begin
    TempPiece := Board[Position.CoordRow, Position.CoordCol].PPiece.Piece;

    For I := Position.CoordRow - 1 To Position.CoordRow + 1 Do // исследуем квадрат 3 на 3
        For J := Position.CoordCol - 1 To Position.CoordCol + 1 Do
        Begin
            If ((I > -1) And (I < 8) And (Position.CoordCol > -1) And (Position.CoordCol < 8)) Then
            Begin
                If (Board[I, J].PPiece = Nil) Or (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight) Then
                Begin
                    Iteration(TempPointer, PointerMove, I, J, MovesExist);
                End;
            End;
        End;
End;

Procedure SearchVertAndHorizMoves(Position: TLocation; Board: TBoard; Var TempPointer, PointerMove: TPPossibleMoves;
    Var MovesExist: Boolean);
Var
    Directions, I: Integer;
    IsStop: Boolean;
    TempPiece: TPiece;
Begin
    TempPiece := Board[Position.CoordRow, Position.CoordCol].PPiece.Piece;

    For Directions := 1 To 4 Do // количество направлений
    Begin
        IsStop := False;
        Case Directions Of
            1: // идем влево
                Begin
                    I := Position.CoordCol - 1;
                    If I > -1 Then
                        While (I > -1) And ((Board[Position.CoordRow, I].PPiece = Nil) Or
                            (Board[Position.CoordRow, I].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, Position.CoordRow, I, MovesExist);

                            If ((Board[Position.CoordRow, I].PPiece <> Nil) And
                                (Board[Position.CoordRow, I].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Dec(I);
                        End;
                End;
            2: // идем вправо
                Begin
                    I := Position.CoordCol + 1;
                    If I < 8 Then
                        While (I < 8) And ((Board[Position.CoordRow, I].PPiece = Nil) Or
                            (Board[Position.CoordRow, I].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, Position.CoordRow, I, MovesExist);

                            If ((Board[Position.CoordRow, I].PPiece <> Nil) And
                                (Board[Position.CoordRow, I].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Inc(I);
                        End;
                End;
            3: // идем вниз
                Begin
                    I := Position.CoordRow + 1;
                    If I < 8 Then
                        While (I < 8) And ((Board[I, Position.CoordCol].PPiece = Nil) Or
                            (Board[I, Position.CoordCol].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, I, Position.CoordCol, MovesExist);

                            If ((Board[I, Position.CoordCol].PPiece <> Nil) And
                                (Board[I, Position.CoordCol].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Inc(I);
                        End;
                End;
            4: // идем вверх
                Begin
                    I := Position.CoordRow - 1;
                    If I > -1 Then
                        While (I > -1) And ((Board[I, Position.CoordCol].PPiece = Nil) Or
                            (Board[I, Position.CoordCol].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, I, Position.CoordCol, MovesExist);

                            If ((Board[I, Position.CoordCol].PPiece <> Nil) And
                                (Board[I, Position.CoordCol].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Dec(I);
                        End;
                End;
        End;
    End;
End;

Procedure SearchDiagonalMoves(Position: TLocation; Board: TBoard; Var TempPointer, PointerMove: TPPossibleMoves;
    Var MovesExist: Boolean);
Var
    Directions, I, J: Integer;
    IsStop: Boolean;
    TempPiece: TPiece;
Begin
    TempPiece := Board[Position.CoordRow, Position.CoordCol].PPiece.Piece;

    For Directions := 1 To 4 Do // количество направлений
    Begin
        IsStop := False;
        Case Directions Of
            1: // идем в левый верхний угол
                Begin
                    I := Position.CoordRow - 1;
                    J := Position.CoordCol - 1;
                    If (I > -1) And (J > -1) Then
                        While (I > -1) And (J > -1) And
                            ((Board[I, J].PPiece = Nil) Or (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, I, J, MovesExist);

                            If ((Board[I, J].PPiece <> Nil) And
                                (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Dec(I);
                            Dec(J);
                        End;
                End;
            2: // идем в правый верхний
                Begin
                    I := Position.CoordRow - 1;
                    J := Position.CoordCol + 1;
                    If (I > -1) And (J < 8) Then
                        While (I > -1) And (J < 8) And
                            ((Board[I, J].PPiece = Nil) Or (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, I, J, MovesExist);

                            If ((Board[I, J].PPiece <> Nil) And
                                (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Dec(I);
                            Inc(J);
                        End;
                End;
            3: // идем в правый нижний
                Begin
                    I := Position.CoordRow + 1;
                    J := Position.CoordCol + 1;
                    If (I < 8) And (J < 8) Then
                        While (I < 8) And (J < 8) And
                            ((Board[I, J].PPiece = Nil) Or (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, I, J, MovesExist);

                            If ((Board[I, J].PPiece <> Nil) And
                                (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Inc(I);
                            Inc(J);
                        End;
                End;
            4: // идем в левый нижний
                Begin
                    I := Position.CoordRow + 1;
                    J := Position.CoordCol - 1;
                    If (I < 8) And (J > -1) Then
                        While (I < 8) And (J > -1) And
                            ((Board[I, J].PPiece = Nil) Or (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) And
                            (IsStop = False) Do
                        Begin
                            Iteration(TempPointer, PointerMove, I, J, MovesExist);

                            If ((Board[I, J].PPiece <> Nil) And
                                (Board[I, J].PPiece.Piece.IsLightPiece <> TempPiece.IsLight)) Then
                                IsStop := True;
                            Inc(I);
                            Dec(J);
                        End;
                End;
        End;
    End;
End;

Procedure SearchKnightMoves(Position: TLocation; Board: TBoard; Var TempPointer, PointerMove: TPPossibleMoves;
    Var MovesExist: Boolean);
Var
    I, J: Integer;
    TempPiece: TPiece;
Begin
    TempPiece := Board[Position.CoordRow, Position.CoordCol].PPiece.Piece;

    For I := Position.CoordRow - 2 To Position.CoordRow + 2 Do // исследуем квадрат 5 на 5
        For J := Position.CoordCol - 2 To Position.CoordCol + 2 Do
        Begin
            If (I > -1) And (I < 8) And (J > -1) And (J < 8) And
                ((I <> Position.CoordRow) And (J <> Position.CoordCol)) Then
            Begin
                If (((Abs(I - Position.CoordRow) = 2) And (Abs(J - Position.CoordCol) = 1)) Or
                    ((Abs(I - Position.CoordRow) = 1) And (Abs(J - Position.CoordCol) = 2))) And
                    ((Board[I, J].PPiece = Nil) Or (Board[I, J].PPiece.Piece.IsLight <> TempPiece.IsLight)) Then
                Begin
                    Iteration(TempPointer, PointerMove, I, J, MovesExist);
                End;
            End;
        End;
End;

Procedure TPawn.SearchPawnMoves(Position: TLocation; Board: TBoard; Var TempPointer, PointerMove: TPPossibleMoves;
    Var MovesExist: Boolean);
Var
    I, J, Start: Integer;
    IsStop: Boolean;
    TempPiece: TPiece;
Begin
    TempPiece := Board[Position.CoordRow, Position.CoordCol].PPiece.Piece;

    If TempPiece.IsLight Then
    Begin
        I := Position.CoordRow - 1;
        Start := (Position.CoordCol - 1);

        For J := Start To (Position.CoordCol + 1) Do
            If ((I > -1) And (I < 8) And (J > -1) And (J < 8)) Then
            Begin
                If (Board[I, J].PPiece = Nil) Then
                Begin
                    If (J = Position.CoordCol) Then
                    Begin
                        Iteration(TempPointer, PointerMove, I, Position.CoordCol, MovesExist);
                    End
                End
                Else
                    If ((Board[I, J].PPiece.Piece.IsLight) <> TempPiece.IsLight) And (J <> Position.CoordCol) Then
                    Begin
                        Iteration(TempPointer, PointerMove, I, J, MovesExist);
                    End
            End;

        If FirstMove Then
        Begin
            Dec(I);
            If ((I > -1) And (I < 8) And (Position.CoordCol > -1) And (Position.CoordCol < 8)) Then
            Begin
                If (Board[I, Position.CoordCol].PPiece = Nil) Then
                Begin
                    Iteration(TempPointer, PointerMove, I, Position.CoordCol, MovesExist);
                End
            End;
        End;
    End
    Else
    Begin
        I := Position.CoordRow + 1;
        Start := (Position.CoordCol - 1);

        For J := Start To (Position.CoordCol + 1) Do
            If ((I > -1) And (I < 8) And (J > -1) And (J < 8)) Then
            Begin
                If (Board[I, J].PPiece = Nil) Then
                Begin
                    If (J = Position.CoordCol) Then
                    Begin
                        Iteration(TempPointer, PointerMove, I, Position.CoordCol, MovesExist);
                    End
                End
                Else
                    If ((Board[I, J].PPiece.Piece.IsLight) <> IsLight) And (J <> Position.CoordCol) Then
                    Begin
                        Iteration(TempPointer, PointerMove, I, J, MovesExist);
                    End
            End;

        If FirstMove Then
        Begin
            Inc(I);
            If ((I > -1) And (I < 8) And (Position.CoordCol > -1) And (Position.CoordCol < 8)) Then
            Begin
                If (Board[I, Position.CoordCol].PPiece = Nil) Then
                Begin
                    Iteration(TempPointer, PointerMove, I, Position.CoordCol, MovesExist);
                End
            End;
        End;
    End;
End;

Function TPiece.MakeMove(Board: TBoard; Dest: TLocation; Var IsWhiteTurn: Boolean): TPMove;
Var
    Head, PMove: TPMove;
    TempPos: TLocation;
Begin
    New(PMove);

    PMove.Source.CoordRow := Position.CoordRow;
    PMove.Source.CoordCol := Position.CoordCol;
    PMove.Dest.CoordRow := Dest.CoordRow;
    PMove.Dest.CoordCol := Dest.CoordCol;
    PMove.Piece := Board[Position.CoordRow, Position.CoordCol].PPiece.Piece;
    PMove.Kind := TNormal;

    If Board[Dest.CoordRow, Dest.CoordCol].PPiece <> Nil Then
        PMove.Capture := True
    Else
        PMove.Capture := False;

    TempPos.CoordRow := Dest.CoordRow;
    TempPos.CoordCol := Dest.CoordCol;
    Board[Dest.CoordRow, Dest.CoordCol].PPiece := Board[Position.CoordRow, Position.CoordCol].PPiece;
    Board[Position.CoordRow, Position.CoordCol].PPiece := Nil;
    Position := TempPos;

    IsWhiteTurn := Not IsWhiteTurn;
    PMove^.Next := Head;
    Head := PMove;
    MakeMove := Head;
End;

Function TPawn.MakeMove(Board: TBoard; Dest: TLocation; Var IsWhiteTurn: Boolean): TPMove;
Var
    Head, PMove: TPMove;
    TempPos: TLocation;
Begin
    New(PMove);

    If IsFirstMove Then
        IsFirstMove := False;

    PMove.Source.CoordRow := Position.CoordRow;
    PMove.Source.CoordCol := Position.CoordCol;
    PMove.Dest.CoordRow := Dest.CoordRow;
    PMove.Dest.CoordCol := Dest.CoordCol;
    PMove.Piece := Board[Position.CoordRow, Position.CoordCol].PPiece.Piece;

    If Board[Dest.CoordRow, Dest.CoordCol].PPiece <> Nil Then
        PMove.Capture := True
    Else
        PMove.Capture := False;

    If ((GetIsLight) And ((Dest.CoordRow) = 0)) Or ((GetIsLight = False) And (Dest.CoordRow = 7)) Then
        PMove.Kind := TPawnPromote
    Else
        PMove.Kind := TNormal;
    // алгос для взятия на проходе

    TempPos.CoordRow := Dest.CoordRow;
    TempPos.CoordCol := Dest.CoordCol;
    Board[Dest.CoordRow, Dest.CoordCol].PPiece := Board[Position.CoordRow, Position.CoordCol].PPiece;
    Board[Position.CoordRow, Position.CoordCol].PPiece := Nil;
    Position := TempPos;

    IsWhiteTurn := Not IsWhiteTurn;
    PMove^.Next := Head;
    Head := PMove;
    MakeMove := Head;
End;

Function TKing.MakeMove(Board: TBoard; Dest: TLocation; Var IsWhiteTurn: Boolean): TPMove;
Var
    Head, PMove: TPMove;
    TempPos: TLocation;
Begin
    New(PMove);

    PMove.Source.CoordRow := Position.CoordRow;
    PMove.Source.CoordCol := Position.CoordCol;
    PMove.Dest.CoordRow := Dest.CoordRow;
    PMove.Dest.CoordCol := Dest.CoordCol;
    PMove.Piece := Board[PMove.Source.CoordRow, PMove.Source.CoordCol].PPiece.Piece;

    If Abs(PMove.Dest.CoordCol - PMove.Source.CoordCol) > 1 Then
    Begin
        IsCastled := True;
        PMove.Kind := TCastling;
        If PMove.Dest.CoordCol > PMove.Source.CoordCol Then
        Begin
            TempPos.CoordRow := PMove.Source.CoordRow;
            TempPos.CoordCol := PMove.Source.CoordCol + 1;
            Board[PMove.Source.CoordRow, PMove.Source.CoordCol + 1].PPiece := Board[PMove.Source.CoordRow, 7].PPiece;
            Board[PMove.Source.CoordRow, 7].PPiece.Piece.Position := TempPos;
            Board[PMove.Source.CoordRow, 7].PPiece := Nil;
        End
        Else
        Begin
            TempPos.CoordRow := PMove.Source.CoordRow;
            TempPos.CoordCol := PMove.Source.CoordCol - 1;
            Board[PMove.Source.CoordRow, PMove.Source.CoordCol - 1].PPiece := Board[PMove.Source.CoordRow, 0].PPiece;
            Board[PMove.Source.CoordRow, 0].PPiece.Piece.Position := TempPos;
            Board[PMove.Source.CoordRow, 0].PPiece := Nil;
        End;
    End;

    If Board[PMove.Dest.CoordRow, PMove.Dest.CoordCol].PPiece <> Nil Then
        PMove.Capture := True
    Else
        PMove.Capture := False;

    Board[PMove.Dest.CoordRow, PMove.Dest.CoordCol].PPiece :=
        Board[PMove.Source.CoordRow, PMove.Source.CoordCol].PPiece;
    Board[PMove.Source.CoordRow, PMove.Source.CoordCol].PPiece := Nil;
    Position := Dest;

    IsPossibleCastle := False;
    IsWhiteTurn := Not IsWhiteTurn;
    PMove^.Next := Head;
    Head := PMove;
    MakeMove := Head;
End;

Function TChessEngine.FindIsCheck(Board: TBoard; King: TPListOfPieces): Boolean;
Var
    TempCol, TempRow: Integer;
    ListOfPossibleMoves, PointerMove, TempPointer: TPPossibleMoves;
    IsCheck, MovesExist: Boolean;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;
    MovesExist := False;
    IsCheck := False;

    SearchVertAndHorizMoves(King.Piece.PiecePosition, Board, TempPointer, PointerMove, MovesExist);
    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    While (ListOfPossibleMoves <> Nil) And (IsCheck = False) Do
    Begin
        TempRow := ListOfPossibleMoves.PossibleMove.CoordRow;
        TempCol := ListOfPossibleMoves.PossibleMove.CoordCol;

        If (Board[TempRow, TempCol].PPiece <> Nil) And
            ((Board[TempRow, TempCol].PPiece.Piece Is TRook) Or (Board[TempRow, TempCol].PPiece.Piece Is TQueen)) And
            (Board[TempRow, TempCol].PPiece.Piece.IsLight <> King.Piece.IsLight) Then
            IsCheck := True;

        ListOfPossibleMoves := ListOfPossibleMoves^.Next;
    End;

    ListOfPossibleMoves := PointerMove;
    MovesExist := False;
    SearchDiagonalMoves(King.Piece.PiecePosition, Board, TempPointer, PointerMove, MovesExist);
    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    While (ListOfPossibleMoves <> Nil) And (IsCheck = False) Do
    Begin
        TempRow := ListOfPossibleMoves.PossibleMove.CoordRow;
        TempCol := ListOfPossibleMoves.PossibleMove.CoordCol;

        If (Board[TempRow, TempCol].PPiece <> Nil) And ((Board[TempRow, TempCol].PPiece.Piece Is TBishop) Or
            (Board[TempRow, TempCol].PPiece.Piece Is TQueen)) And
            (Board[TempRow, TempCol].PPiece.Piece.IsLight <> King.Piece.IsLight) Then
            IsCheck := True;

        ListOfPossibleMoves := ListOfPossibleMoves^.Next;
    End;

    ListOfPossibleMoves := PointerMove;
    MovesExist := False;
    SearchKnightMoves(King.Piece.PiecePosition, Board, TempPointer, PointerMove, MovesExist);
    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    While (ListOfPossibleMoves <> Nil) And (IsCheck = False) Do
    Begin
        TempRow := ListOfPossibleMoves.PossibleMove.CoordRow;
        TempCol := ListOfPossibleMoves.PossibleMove.CoordCol;

        If (Board[TempRow, TempCol].PPiece <> Nil) And (Board[TempRow, TempCol].PPiece.Piece Is TNKnight) And
            (Board[TempRow, TempCol].PPiece.Piece.IsLight <> King.Piece.IsLight) Then
            IsCheck := True;

        ListOfPossibleMoves := ListOfPossibleMoves^.Next;
    End;

    FindIsCheck := IsCheck;
End;

Function TKing.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    I, J: Integer;
    ListOfPossibleMoves, PointerMove, TempPointer: TPPossibleMoves;
    MovesExist, TempIsPossibleCastle: Boolean;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;
    MovesExist := False;
    TempIsPossibleCastle := IsPossibleCastle;

    SearchKingMoves(Position, Board, TempPointer, PointerMove, MovesExist);

    If TempIsPossibleCastle Then
    Begin
        For I := Position.CoordCol + 1 To Position.CoordCol + 2 Do
            If (Board[Position.CoordRow, I].PPiece <> Nil) Then
                TempIsPossibleCastle := False;

        If ((TempIsPossibleCastle) And (Board[Position.CoordRow, Position.CoordCol + 3].PPiece.Piece Is TRook) And
            (Board[Position.CoordRow, Position.CoordCol + 3].PPiece.Piece.IsLight = IsLight)) Then
        Begin
            Iteration(TempPointer, PointerMove, Position.CoordRow, Position.CoordCol + 2, MovesExist);
        End;

        For I := Position.CoordCol - 1 DownTo Position.CoordCol - 3 Do
            If (Board[Position.CoordRow, I].PPiece <> Nil) Then
                TempIsPossibleCastle := False;

        If ((TempIsPossibleCastle) And (Board[Position.CoordRow, Position.CoordCol - 4].PPiece.Piece Is TRook) And
            (Board[Position.CoordRow, Position.CoordCol - 4].PPiece.Piece.IsLight = IsLight)) Then
        Begin
            Iteration(TempPointer, PointerMove, Position.CoordRow, Position.CoordCol - 2, MovesExist);
        End;
    End;

    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TQueen.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    ListOfPossibleMoves, PointerMove, TempPointer: TPPossibleMoves;
    MovesExist: Boolean;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;
    MovesExist := False;

    SearchVertAndHorizMoves(Position, Board, TempPointer, PointerMove, MovesExist);
    SearchDiagonalMoves(Position, Board, TempPointer, PointerMove, MovesExist);

    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TRook.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    ListOfPossibleMoves, PointerMove, TempPointer: TPPossibleMoves;
    MovesExist: Boolean;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;
    MovesExist := False;

    SearchVertAndHorizMoves(Position, Board, TempPointer, PointerMove, MovesExist);

    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TBishop.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    ListOfPossibleMoves, PointerMove, TempPointer: TPPossibleMoves;
    MovesExist: Boolean;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;
    MovesExist := False;

    SearchDiagonalMoves(Position, Board, TempPointer, PointerMove, MovesExist);

    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TNKnight.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    ListOfPossibleMoves, PointerMove, TempPointer: TPPossibleMoves;
    MovesExist: Boolean;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;
    MovesExist := False;

    SearchKnightMoves(Position, Board, TempPointer, PointerMove, MovesExist);

    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    FindPossibleMoves := ListOfPossibleMoves;
End;

Function TPawn.FindPossibleMoves(Position: TLocation; Board: TBoard): TPPossibleMoves;
Var
    ListOfPossibleMoves, PointerMove, TempPointer: TPPossibleMoves;
    MovesExist: Boolean;
Begin
    New(PointerMove);
    ListOfPossibleMoves := PointerMove;
    MovesExist := False;

    SearchPawnMoves(Position, Board, TempPointer, PointerMove, MovesExist);

    If MovesExist Then
        TempPointer^.Next := Nil
    Else
        ListOfPossibleMoves := Nil;

    FindPossibleMoves := ListOfPossibleMoves;
End;

End.
