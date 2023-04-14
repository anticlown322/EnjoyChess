Unit EnjoyChessBackEngine;

Interface

Uses
    System.Generics.Collections,
    System.Diagnostics,
    SysUtils,
    Classes,
    Graphics;

Type
    { Общее }

    TLocation = Record
        CoordX: 0 .. 8; // 0 - для ходов за пределы доски и отсуствия на доске
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
        PieceImage: TBitmap;
        // FigureID: Byte;
        // Function IsCheck(Position: TLocation): Boolean; Virtual; Abstract;
        // Function IsPossibleMove(Position: TLocation): Boolean; Virtual; Abstract;
        // Procedure MoveFigure(Position: TLocation); Virtual;
    Public
        Property Position: TLocation Read FigurePosition;
        Property IsLight: Boolean Read IsLightPiece;
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Virtual; Abstract;
        Destructor Destroy; Override;
    End;

    TKing = Class(TPiece)
    Private
        IsPossibleCastle: Boolean;
        IsAlreadyCastled: Boolean;
        // Function IsPossibleMove(Position: TLocation): Boolean; Override;
    Public
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
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

    TKnight = Class(TPiece)
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
        Constructor Create(Position: TLocation; IsLightPiece: Boolean); Override;
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
        // Procedure FindPossibleMovesOfPiece();
        // Procedure ForEveryCell(CellProc: TCellProc);
    Public
        Board: TBoard;
        GameState: TGameState;
        // Sound: TEnjoyChessSound;
        Procedure InitializeBoard();
        // Constructor Create();
    End;

Implementation

{ Для фигур }

Constructor TPiece.Create(Position: TLocation; IsLightPiece: Boolean);
Var
    PieceName: String;
Begin
{
        PieceName := UpperCase(Copy(ClassName, 2, Length(ClassName) - 1));
        PieceImage := TBitmap.Create;
        PieceImage.Transparent := True;

            If Skin = Figskin5 Then
                PieceImage.LoadFromResourceName(HInstance, PieceName + '_5')
            Else
                If Skin = Figskin4 Then
                    PieceImage.LoadFromResourceName(HInstance, PieceName + '_4')
                Else
                    If Skin = Figskin3 Then
                        PieceImage.LoadFromResourceName(HInstance, PieceName + '_3')
                    Else
                        If Skin = Figskin2 Then
                            PieceImage.LoadFromResourceName(HInstance, PieceName + '_2')
                        Else
                            PieceImage.LoadFromResourceName(HInstance, PieceName);
        BackColor := PieceImage.Canvas.Pixels[0, 0];
        If Not FColor_White Then
            PieceImage.Canvas.CopyRect(Rect(0, 0, PieceImage.Width Div 2, PieceImage.Height), PieceImage.Canvas,
                Rect(PieceImage.Width Div 2 + 1, 0, PieceImage.Width, PieceImage.Height));
        PieceImage.Width := PieceImage.Width Div 2;
        Shift_x := (Round((ChessBoard.CellWidth / 2) - (PieceImage.Width / 2)));
        Shift_y := (Round((ChessBoard.CellHeight / 2) - (PieceImage.Height / 2)));
        FPaintBox := TPaintBox.Create(ChessBoard);
        FPaintBox.Parent := ChessBoard.Parent;
        FPaintBox.OnPaint := Paint_figure;
        FPaintBox.Width := PieceImage.Width;
        FPaintBox.Height := PieceImage.Height;
        FPaintBox.Left := ChessBoard.GetXYtoPos(Position).ABS_X + Shift_x;
        FPaintBox.Top := ChessBoard.GetXYtoPos(Position).ABS_Y + Shift_y;
        FPaintBox.Visible := True;
        FPaintBox.OnMouseDown := MouseDown_;
        FPaintBox.OnMouseUp := MouseUp_;
        If PieceName = UpperCase('Pawn') Then
            FID := Fid_pawn;
        If PieceName = UpperCase('Rook') Then
            FID := Fid_rook;
        If PieceName = UpperCase('Knight') Then
            FID := Fid_Knight;
        If PieceName = UpperCase('Queen') Then
            FID := Fid_Queen;
        If PieceName = UpperCase('BISHOP') Then
            FID := Fid_BISHOP;
        If PieceName = UpperCase('King') Then
            FID := Fid_king;
}
End;

Destructor TPiece.Destroy;
Begin
{
        FBmp.Free;
        FPaintBox.Free;
}
    Inherited;
End;

Constructor TPawn.Create(Position: TLocation; IsLightPiece: Boolean);
Begin
    Inherited Create(Position, IsLightPiece);
    FirstMove := True;
End;

Constructor TKing.Create(Position: TLocation; IsLightPiece: Boolean);
Begin
    Inherited Create(Position, IsLightPiece);
    IsPossibleCastle := True;
    IsAlreadyCastled := False;
End;

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
