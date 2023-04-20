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
    { ����� }

    TLocation = Record
        CoordX: 0 .. 8; // 0 - ��� ����� �� ������� ����� � ��������� �� �����
        CoordY: 0 .. 8;
    End;

    { ��� ����� }

    TPiece = Class
    Private
        PiecePosition: TLocation;
        IsLightPiece: Boolean;
        PieceBitmap: TBitmap;
        // Function IsCheck(Position: TLocation): Boolean; Virtual; Abstract;
        // Function IsPossibleMove(Position: TLocation): Boolean; Virtual; Abstract;
    Protected
        //Procedure SetBitmap();
        //Function GetPosition(): TLocation;
        //Function GetIsLight(): Boolean;
    Public
        Property Position: TLocation Read PiecePosition;
        Property IsLight: Boolean Read IsLightPiece;
        Property PBitmap: TBitmap Read PieceBitmap Write PieceBitmap;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
            CellSide: Integer); Virtual;
        Destructor Destroy; Override;
    End;

    TKing = Class(TPiece)
    Private
        IsPossibleCastle: Boolean;
        IsAlreadyCastled: Boolean;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Public
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
        // N ���������� ���������, �.�. ��� ������ �� ������� �������� ������ ����� ������
    Private
        // Function IsCheck(Position: TLocation): Boolean; Override;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
    End;

    TPawn = Class(TPiece)
    Private
        FirstMove: Boolean;
        // Function IsCheck(Position: TLocation): Boolean; Override;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Public
        Constructor Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
            CellSide: Integer); Override;
    End;

    TPListOfPieces = ^TListOfPieces;

    TListOfPieces = Record
        Piece: TPiece;
        Next: TPListOfPieces;
    End;

    { ��� ����� � ����������� }

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

    { ��� ������ ����� }

    TBoardCell = Record
    Public
        Piece: TPListOfPieces;
        IsLight: Boolean;
        CoordX, CoordY: Integer;
    End;

    TCellProc = Reference To Procedure(Var Cell: TBoardCell);

    TBoard = Array Of Array OF TBoardCell;

    { ����� ������� ������, ��������������� �����. ���� ��������� ����� ����� � ������ ���� }

    TGameState = (Playing, WhiteWin, BlackWin, Draw);

    TChessEngine = Class
    Private
        ExistingPieces: TPListOfPieces;
        TakenWhitePieces: TPListOfPieces;
        TakenBlackPieces: TPListOfPieces;
        FirstMove: Boolean;
        // Procedure CheckWinState();
    Protected
        // Procedure FindPossibleMovesOfPiece();
        // Procedure ForEveryCell(CellProc: TCellProc);
    Public
        Board: TBoard;
        GameState: TGameState;
        // Sound: TEnjoyChessSound;
        Procedure InitializeBoard(BoardPaintBox: TPaintBox; CellSide: Integer);
    End;

Implementation

{ ��� ����� }

Constructor TPiece.Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
    CellSide: Integer);
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
    TempPNG.LoadFromFile('skins\tatiana\' + PieceName + '.png');
    PieceBitmap.Assign(TempPNG);
    TempPNG.Free;
End;

Destructor TPiece.Destroy;
Begin
    PieceBitmap.Free;
    Inherited;
End;

Constructor TPawn.Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
    CellSide: Integer);
Begin
    Inherited Create(Position, IsLightPiece, PBBoard, CellSide);
    FirstMove := True;
End;

Constructor TKing.Create(Position: TLocation; IsLightPiece: Boolean; PBBoard: TPaintBox;
    CellSide: Integer);
Begin
    Inherited Create(Position, IsLightPiece, PBBoard, CellSide);
    IsPossibleCastle := True;
    IsAlreadyCastled := False;
End;

{ ��� ����� }

Procedure TChessEngine.InitializeBoard(BoardPaintBox: TPaintBox; CellSide: Integer);
Const
    ROW_COUNT = 8;
    COL_COUNT = 8;
Var
    I, J: Integer;
    TempPos: TLocation;
    PiecePointer: TPListOfPieces;
Begin
    SetLength(Board, COL_COUNT, ROW_COUNT);

    { ������� ����� }

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

    { ������� ����� }

    New(PiecePointer);
    ExistingPieces := PiecePointer;

    // � ������ �������� ���� + � ������� board ���������� � ����

    For I := 1 To 8 Do
    Begin
        // ������ ������
        TempPos.CoordX := Board[I - 1, 0].CoordX;
        TempPos.CoordY := Board[I - 1, 0].CoordY;

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

        Board[I - 1, 0].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;

        // ����� ������
        TempPos.CoordX := Board[I - 1, 7].CoordX;
        TempPos.CoordY := Board[I - 1, 7].CoordY;

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
        Board[I - 1, 7].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;
    End;

    For I := 1 To 8 Do
    Begin
        // ������ �����
        TempPos.CoordX := Board[I - 1, 1].CoordX;
        TempPos.CoordY := Board[I - 1, 1].CoordY;

        PiecePointer.Piece := TPawn.Create(TempPos, False, BoardPaintBox, CellSide);

        PiecePointer.Piece.PiecePosition.CoordX := TempPos.CoordX;
        PiecePointer.Piece.PiecePosition.CoordY := TempPos.CoordY;

        Board[I - 1, 1].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;

        // ����� �����
        TempPos.CoordX := Board[I - 1, 6].CoordX;
        TempPos.CoordY := Board[I - 1, 6].CoordY;

        PiecePointer.Piece := TPawn.Create(TempPos, True, BoardPaintBox, CellSide);

        PiecePointer.Piece.PiecePosition.CoordX := TempPos.CoordX;
        PiecePointer.Piece.PiecePosition.CoordY := TempPos.CoordY;

        Board[I - 1, 6].Piece := PiecePointer;

        New(PiecePointer^.Next);
        PiecePointer := PiecePointer^.Next;
    End;

    PiecePointer^.Next := Nil;

    GameState := Playing;
    FirstMove := True;
End;

End.
