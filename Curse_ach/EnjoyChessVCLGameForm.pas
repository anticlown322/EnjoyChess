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
    Vcl.ActnList, EnjoyChessBackEngine, EnjoyChessDataImages,
  EnjoyChessVCLAnalysis, EnjoyChessVCLSettings, EnjoyChessVCLWelcomeWindow;

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
        procedure DrawCell(CoordX, Coordy: Integer; CellRect: TRect; BoardCanvas: TCanvas);
        Procedure InitializeBoard();
        function CellSize(): Integer;
        procedure UpdateScreen();
        function Cell(CoordX, CoordY: Integer): TBoardCell;
    End;

    TChessBoard = Class(TImage)
    Private
        CellSide: Integer;
    Protected
        // Procedure DrawBoard();
        // Procedure DrawCell();
    Public
        // Procedure MouseDown();
        // Procedure MouseUp();
    End;

Var
    FrmGameForm: TfrmGameForm;

Implementation

{$R *.dfm}

Procedure TChessBoard.DrawCell(X, Y: Integer; CellRect: TRect; BoardCanvas: TCanvas;
    IsLightSquare: Boolean);
Var
    Cell: TBoardCell;
    CellX, CellY: Integer;
    Str: String;
Begin
    Cell :=
End;

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
        Application.Terminate
    Else
        CanClose := False;
End;

Procedure TfrmGameForm.FormDestroy(Sender: TObject);
Begin
    ChessEngine.Free;
End;

Procedure TfrmGameForm.InitializeBoard();
Begin
    ChessEngine.InitializeBoard();
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
    {
      FrmGameForm.Hide;
      if not Assigned(FrmAnalysis) Then
      FrmAnalysis := TfrmAnalysis.Create();
      FrmAnalysis.Show;
      FrmGameForm.Free;
    }
End;

Procedure TfrmGameForm.PMenuButtonSettingsClick(Sender: TObject);
Begin
    {
      frmGameForm.CanClose(Sender, IsClose);
      If IsClose Then
      Begin
      FrmSettings := TfrmSettings.Create(Self);
      FrmSettings.Show;
      End;
    }
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
Var
    CoordX, CoordY: Integer;
    IsLightCell: Boolean;
    CellColor: TColor;
    BoardCanvas: TCanvas;
    CellRect: TRect;
Begin
    BoardCanvas := FrmGameForm.PbBoard.Canvas;
    IsLightCell := False;

    For CoordX := 0 To FrmGameForm.PBoard.Width Do
    Begin
        For CoordY := 0 To FrmGameForm.PBoard.Height Do
        Begin
            CellRect := Rect(CoordX * CellSide + 1, CoordY * CellSide + 1, (CoordX + 1) * CellSide,
                (CoordY + 1) * CellSide);
            DrawCell(CoordX, CoordY, CellRect, BoardCanvas, IsLightCell);
            IsLightCell := Not IsLightCell;
        End;
    End;
End;

End.
