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
    Private
        ChessEngine: TChessEngine;
        Procedure DrawCell(CoordX, CoordY: Integer; CellRect: TRect; BoardCanvas: TCanvas;
            IsLightSquare: Boolean);
        Procedure InitializeBoard();
        Function CellSize(): Integer;
        Procedure UpdateScreen();
        Function Cell(CoordX, CoordY: Integer): TBoardCell;
    End;

Var
    FrmGameForm: TfrmGameForm;

Implementation

{$R *.dfm}
{ сама форма }

Procedure TfrmGameForm.FormCreate(Sender: TObject);
Begin
    ChessEngine := TChessEngine.Create;
    InitializeBoard();
End;

Procedure TfrmGameForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Application.MessageBox
        (PChar('Вы уверены, что хотите выйти? Несохраненные данные будут утеряны.'), PChar('Выход'),
        MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1 + MB_TASKMODAL) = IDYES Then
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
    If Not Assigned(FrmAnalysis) Then
        FrmAnalysis := TfrmAnalysis.Create(Self);
    FrmGameForm.Hide;
    FrmAnalysis.Show;
End;

Procedure TfrmGameForm.PMenuButtonSettingsClick(Sender: TObject);
Begin
    If Not Assigned(FrmAnalysis) Then
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
    CoordX, CoordY, CellSide: Integer;
    BoardCanvas: TCanvas;
    CellRect: TRect;
    IsLightSquare: Boolean;
Begin
    BoardCanvas := FrmGameForm.PbBoard.Canvas;
    IsLightSquare := True;

    CellSide := CellSize();

    For CoordX := 0 To ROW_COUNT - 1 Do
    Begin
        For CoordY := 0 To COL_COUNT - 1 Do
        Begin
            CellRect := Rect(CoordX * CellSide, CoordY * CellSide, (CoordX + 1) * CellSide,
                (CoordY + 1) * CellSide);
            DrawCell(CoordX, CoordY, CellRect, BoardCanvas, IsLightSquare);
            IsLightSquare := Not IsLightSquare;
        End;
        IsLightSquare := Not IsLightSquare;
    End;

End;

Procedure TfrmGameForm.DrawCell(CoordX, CoordY: Integer; CellRect: TRect; BoardCanvas: TCanvas;
    IsLightSquare: Boolean);
Var
    Cell: TBoardCell;
Begin
    Cell := ChessEngine.Board[CoordX, CoordY];

    If IsLightSquare Then
        BoardCanvas.Brush.Color := $F0D9B5
    Else
        BoardCanvas.Brush.Color := $B58863;

    BoardCanvas.FillRect(CellRect);
End;

Function TfrmGameForm.CellSize(): Integer;
Begin
    CellSize := (PbBoard.Width - 1) Div 8
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
    If ChessEngine.GameState In [WhiteWin, BlackWin, Draw] Then; //
End;

End.
