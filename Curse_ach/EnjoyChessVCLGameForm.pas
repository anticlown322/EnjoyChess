Unit EnjoyChessVCLGameForm;

Interface

Uses
    Winapi.Windows,
    Winapi.Messages,
    System.SysUtils,
    System.Variants,
    System.Classes,
    Vcl.Graphics,
    Vcl.Controls,
    Vcl.Forms,
    Vcl.Dialogs,
    Vcl.ExtCtrls,
    Vcl.WinXPickers,
    Vcl.StdCtrls,
    Vcl.ButtonGroup,
    Vcl.VirtualImage,
    Vcl.WinXCtrls,
    Vcl.Buttons,
    System.ImageList,
    Vcl.ImgList,
    Vcl.VirtualImageList,
    System.Actions,
    Vcl.ActnList,
    EnjoyChessBackEngine,
    EnjoyChessDataImages,
    EnjoyChessVCLAnalysis,
    EnjoyChessVCLSettings,
    EnjoyChessVCLWelcomeWindow;

Type
    TfrmGameForm = Class(TForm)
        PTop: TPanel;
        PLeft: TPanel;
        PRight: TPanel;
        PBoard: TPanel;
        LbTimeOpponent: TLabel;
        LbTimePlayer: TLabel;
        LbnNamePlayer: TLabel;
        LbNameOpponent: TLabel;
        PGameInfo: TPanel;
        LbGameMode: TLabel;
        LbWhitePlayerName: TLabel;
        SplvMenu: TSplitView;
        ViWhiteCircle: TVirtualImage;
        ViBlackCircle: TVirtualImage;
        LbBlackPlayerName: TLabel;
        PGameOptions: TPanel;
        MemNotation: TMemo;
        PMoveOptions: TPanel;
        SdbtToEnding: TSpeedButton;
        SdbtNextMove: TSpeedButton;
        SdbtPrevMove: TSpeedButton;
        SdbtToBegining: TSpeedButton;
        SdbtResign: TSpeedButton;
        SdbtDraw: TSpeedButton;
        VilImages_48: TVirtualImageList;
        VilImages_24: TVirtualImageList;
        GrpBack: TGridPanel;
        ViMenuBar: TVirtualImage;
        LbUsername: TLabel;
        PMenuButtonSettings: TPanel;
        PMenuButtonAnalysis: TPanel;
        PMenuButtonSave: TPanel;
        PMenuButtonBackToWelcome: TPanel;
        PbBoard: TPaintBox;
        ActlAnimation: TActionList;
        LbGameState: TLabel;
        VilIcons: TVirtualImageList;
        SdbtReverse: TSpeedButton;
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure ViMenuBarClick(Sender: TObject);
        Procedure PMenuButtonAnalysisMouseEnter(Sender: TObject);
        Procedure PMenuButtonAnalysisMouseLeave(Sender: TObject);
        Procedure PMenuButtonSaveMouseEnter(Sender: TObject);
        Procedure PMenuButtonSaveMouseLeave(Sender: TObject);
        Procedure PMenuButtonSettingsMouseEnter(Sender: TObject);
        Procedure PMenuButtonSettingsMouseLeave(Sender: TObject);
        Procedure PMenuButtonBackToWelcomeMouseEnter(Sender: TObject);
        Procedure PMenuButtonBackToWelcomeMouseLeave(Sender: TObject);
        Procedure PMenuButtonBackToWelcomeClick(Sender: TObject);
        Procedure PMenuButtonAnalysisClick(Sender: TObject);
        Procedure PMenuButtonSettingsClick(Sender: TObject);
        Procedure PbBoardPaint(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure PbBoardMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    Private
        ChessEngine: TChessEngine;
        Procedure DrawCell(Row, Col: Integer; CellRect: TRect; BufferBitmap: TBitmap);
        Procedure DrawPiece(BufferBitmap: TBitmap; Piece: TPiece);
        Procedure InitializeBoard();
        Function CellSize(): Integer;
        Function Cell(CoordX, CoordY: Integer): TBoardCell;
        Procedure UpdateScreen();
    End;

Var
    FrmGameForm: TfrmGameForm;

Implementation

{$R *.dfm}
{ сама форма }

Procedure TfrmGameForm.FormCreate(Sender: TObject);
Begin
    ChessEngine := TChessEngine.Create;
    // ChessEngine.Sound := TEnjoyChessWindowsSound.Create;
    // Setting := TSettings.Create;
    // дальше все свойства дефолт настроек
    InitializeBoard();
    BorderStyle := BsNone;
    WindowState := WsMaximized;
End;

Procedure TfrmGameForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Application.MessageBox(PChar('Вы уверены, что хотите выйти? Несохраненные данные будут утеряны.'),
        PChar('Выход'), MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1 + MB_TASKMODAL) = IDYES Then
    Begin
        FrmWelcomeWindow.Show;
        CanClose := True
    End
    Else
        CanClose := False;
End;

Procedure TfrmGameForm.FormDestroy(Sender: TObject);
Begin
    ChessEngine.Free;
End;

{ обработка левой подпанели }

Procedure TfrmGameForm.UpdateScreen();
    Procedure UpdateCaption(Caption: String);
    Begin
        LbGameState.Caption := Caption;
    End;

Begin
    PbBoard.Invalidate;
    Case ChessEngine.GameState Of
        WhiteWin:
            UpdateCaption('Белые выиграли!');
        BlackWin:
            UpdateCaption('Черные выиграли!');
        Draw:
            UpdateCaption('Ничья!');
        Playing:
            UpdateCaption('Идет игра...');
    End;
    If ChessEngine.GameState In [WhiteWin, BlackWin, Draw] Then;
End;

{ Обработка панелей-кнопок на SplitView }
{ смена цвета }
Procedure TfrmGameForm.PMenuButtonAnalysisMouseEnter(Sender: TObject);
Begin
    PMenuButtonAnalysis.Color := $00383632;
End;

Procedure TfrmGameForm.PMenuButtonAnalysisMouseLeave(Sender: TObject);
Begin
    PMenuButtonAnalysis.Color := $002B2722;
End;

Procedure TfrmGameForm.PMenuButtonBackToWelcomeMouseEnter(Sender: TObject);
Begin
    PMenuButtonBackToWelcome.Color := $00383632;
End;

Procedure TfrmGameForm.PMenuButtonBackToWelcomeMouseLeave(Sender: TObject);
Begin
    PMenuButtonBackToWelcome.Color := $002B2722;
End;

Procedure TfrmGameForm.PMenuButtonSaveMouseEnter(Sender: TObject);
Begin
    PMenuButtonSave.Color := $00383632;
End;

Procedure TfrmGameForm.PMenuButtonSaveMouseLeave(Sender: TObject);
Begin
    PMenuButtonSave.Color := $002B2722;
End;

Procedure TfrmGameForm.PMenuButtonSettingsMouseEnter(Sender: TObject);
Begin
    PMenuButtonSettings.Color := $00383632;
End;

Procedure TfrmGameForm.PMenuButtonSettingsMouseLeave(Sender: TObject);
Begin
    PMenuButtonSettings.Color := $002B2722;
End;

{ нажатие на кнопки-панели }

Procedure TfrmGameForm.PMenuButtonBackToWelcomeClick(Sender: TObject);
Begin
    FrmGameForm.Hide;
    FrmWelcomeWindow.Show;
    FrmGameForm.Free;
End;

Procedure TfrmGameForm.PMenuButtonAnalysisClick(Sender: TObject);
Begin
    FrmAnalysis := TfrmAnalysis.Create(Self);
    FrmGameForm.Hide;
    FrmAnalysis.Show;
End;

Procedure TfrmGameForm.PMenuButtonSettingsClick(Sender: TObject);
Begin
    FrmSettings := TfrmSettings.Create(Self);
    FrmGameForm.Hide;
    FrmSettings.Show;
End;

Procedure TfrmGameForm.ViMenuBarClick(Sender: TObject);
Begin
    If Not SplvMenu.Opened Then
        SplvMenu.Opened := True
    Else
        SplvMenu.Opened := False;
End;

{ Обработка доски }

Procedure TfrmGameForm.PbBoardPaint(Sender: TObject);
Const
    ROW_COUNT = 8;
    COL_COUNT = 8;
Var
    BoardCanvas: TCanvas;
    CellRect: TRect;
    Col, Row, CellSide: Integer;
    BufferBitmap: TBitmap;
    ExistingPieces: TPListOfPieces;
Begin
    CellSide := CellSize();

    BoardCanvas := FrmGameForm.PbBoard.Canvas;
    BufferBitmap := TBitmap.Create;
    BufferBitmap.Height := COL_COUNT * CellSide;
    BufferBitmap.Width := ROW_COUNT * CellSide;

    // идем из левого верхнего вниз
    For Row := 0 To ROW_COUNT - 1 Do
    Begin
        For Col := 0 To COL_COUNT - 1 Do
        Begin
            CellRect := Rect(Col * CellSide, Row * CellSide, (Col + 1) * CellSide, (Row + 1) * CellSide);
            DrawCell(Row, Col, CellRect, BufferBitmap);
        End;
    End;

    ExistingPieces := ChessEngine.ListOfPieces;

    While ExistingPieces^.Next <> Nil Do
    Begin
        DrawPiece(BufferBitmap, ExistingPieces^.Piece);
        ExistingPieces := ExistingPieces^.Next;
    End;

    Try
        BitBlt(BoardCanvas.Handle, 0, 0, COL_COUNT * CellSide, ROW_COUNT * CellSide,
            BufferBitmap.Canvas.Handle, 0, 0, SRCCOPY);
    Finally
        BufferBitmap.Free;
    End;
End;

Procedure TfrmGameForm.DrawCell(Row, Col: Integer; CellRect: TRect; BufferBitmap: TBitmap);
Var
    CellSide: Integer;
    TempRect: TRect;
Begin
    CellSide := CellSize();
    BufferBitmap.Canvas.Pen.Width := 1;

    { отрисовка клеток }

    If ChessEngine.Board[Row, Col].IsLight Then
    Begin
        BufferBitmap.Canvas.Brush.Color := $E5D3B3; // light
        BufferBitmap.Canvas.Font.Color := $B58863; // dark
    End
    Else
    Begin
        BufferBitmap.Canvas.Brush.Color := $B58863; // dark
        BufferBitmap.Canvas.Font.Color := $E5D3B3; // light
    End;

    BufferBitmap.Canvas.FillRect(CellRect);

    BufferBitmap.Canvas.Font.Style := [FsBold];
    BufferBitmap.Canvas.Font.Size := 8;

    If (Row = 7) Then
    Begin
        BufferBitmap.Canvas.TextOut(Col * CellSide + CellSide Div 10, Row * CellSide + CellSide - 17,
            Chr(ORD('a') + Col));
    End;
    If (Col = 7) Then
    Begin
        BufferBitmap.Canvas.TextOut(Col * CellSide + CellSide - 10, Row * CellSide, IntToStr(8 - Row));
    End;

    If ChessEngine.Board[Row, Col].IsActive Then
    Begin
        BufferBitmap.Canvas.Brush.Color := $829769; // light green
        BufferBitmap.Canvas.FillRect(CellRect);
    End;

    If ChessEngine.Board[Row, Col].IsHighlighted Then
    Begin
        BufferBitmap.Canvas.Pen.Color := $008000; // dark green
        BufferBitmap.Canvas.Pen.Width := 5;
        BufferBitmap.Canvas.Arc(Col * CellSide + 2, Row * CellSide + 2, (Col + 1) * CellSide - 2,
            (Row + 1) * CellSide - 2, Col * CellSide, Row * CellSide, Col * CellSide, Row * CellSide);
    End;

    If ChessEngine.Board[Row, Col].IsPossibleToMove Then
    Begin
        BufferBitmap.Canvas.Brush.Color := $008000; // dark green
        BufferBitmap.Canvas.Pen.Color := $829769; // light green
        TempRect := Rect(Col * CellSide + CellSide Div 4, Row * CellSide + CellSide Div 4,
            (Col + 1) * CellSide - CellSide Div 4, (Row + 1) * CellSide - CellSide Div 4);
        BufferBitmap.Canvas.Ellipse(TempRect);
    End;
End;

Procedure TfrmGameForm.DrawPiece(BufferBitmap: TBitmap; Piece: TPiece);
Var
    CellSide, Coeff: Integer;
    TempBitmap: TBitmap;
Begin
    CellSide := CellSize();

    If WindowState <> WsMaximized Then
    Begin
        TempBitmap := TBitmap.Create;
        TempBitmap.Height := CellSide;
        TempBitmap.Width := CellSide;
        TempBitmap.Transparent := True;
        Coeff := 2;

        Try
            SetStretchBltMode(TempBitmap.Canvas.Handle, STRETCH_HALFTONE);
            StretchBlt(TempBitmap.Canvas.Handle, 0, 0, CellSide, CellSide, Piece.PBitmap.Canvas.Handle, 0, 0,
                CellSide * Coeff, CellSide * Coeff, SRCCopy);
            BufferBitmap.Canvas.Draw(Piece.Position.CoordCol * CellSide + CellSide Div 8 + 2,
                Piece.Position.CoordRow * CellSide + CellSide Div 10 + 2, TempBitmap);
        Finally
            TempBitmap.Free;
        End;
    End
    Else
        BufferBitmap.Canvas.Draw(Piece.Position.CoordCol * CellSide + 12, Piece.Position.CoordRow * CellSide +
            10, Piece.PBitmap);
End;

Function TfrmGameForm.CellSize(): Integer;
Const
    СOL_AND_ROW_COUNT = 8;
Begin
    CellSize := (PbBoard.Width - 1) Div СOL_AND_ROW_COUNT;
End;

Procedure TfrmGameForm.InitializeBoard();
Begin
    ChessEngine.InitializeBoard();
    PbBoard.Invalidate;
End;

Function TfrmGameForm.Cell(CoordX, CoordY: Integer): TBoardCell;
Begin
    Cell := ChessEngine.Board[CoordX, CoordY];
End;

{ обработка нажатий мыши }

Procedure TfrmGameForm.PbBoardMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
Var
    Row, Col, CellSide: Integer;
    PPossibleMoves: TPPossibleMoves;
Begin
    CellSide := CellSize();
    Col := X Div CellSide;
    Row := Y Div CellSide;

    If ChessEngine.GameState <> Playing Then
        Exit;

    Case Button Of
        MbLeft:
            Begin
                If ChessEngine.Board[Row, Col].IsActive = False Then
                Begin
                    ChessEngine.Board[Row, Col].IsActive := True;

                    If ChessEngine.Board[Row, Col].PPiece <> Nil Then
                    Begin
                        PPossibleMoves := ChessEngine.Board[Row, Col].PPiece^.Piece.FindPossibleMoves
                            (ChessEngine.Board[Row, Col].PPiece^.Piece.Position, ChessEngine.Board);
                        While PPossibleMoves <> Nil Do
                        Begin
                            ChessEngine.Board[PPossibleMoves^.PossibleMove.CoordRow,
                                PPossibleMoves^.PossibleMove.CoordCol].IsPossibleToMove := True;
                            PPossibleMoves := PPossibleMoves^.Next;
                        End;
                    End;
                End
                Else
                Begin
                    ChessEngine.Board[Row, Col].IsActive := False;
                End;
            End;
        MbRight:
            Begin
                If ChessEngine.Board[Row, Col].IsHighlighted = False Then
                    ChessEngine.Board[Row, Col].IsHighlighted := True
                Else
                    ChessEngine.Board[Row, Col].IsHighlighted := False;
            End;
    End;

    UpdateScreen();
End;

End.
