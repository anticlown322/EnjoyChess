Unit EnjoyChessVCLAnalysis;

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
    Vcl.WinXCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.VirtualImage;

Type
    TfrmAnalysis = Class(TForm)
        Timer1: TTimer;
    grpBack: TGridPanel;
    pBoard: TPanel;
    pbBoard: TPaintBox;
    pLeft: TPanel;
    pGameInfo: TPanel;
    lbGameMode: TLabel;
    lbWhitePlayerName: TLabel;
    viWhiteCircle: TVirtualImage;
    viBlackCircle: TVirtualImage;
    lbBlackPlayerName: TLabel;
    splvMenu: TSplitView;
    pMenuButtonSettings: TPanel;
    pMenuButtonAnalysis: TPanel;
    pMenuButtonSave: TPanel;
    pMenuButtonBackToWelcome: TPanel;
    pTop: TPanel;
    viMenuBar: TVirtualImage;
    lbUsername: TLabel;
    pRight: TPanel;
    lbTimeOpponent: TLabel;
    lbTimePlayer: TLabel;
    lbnNamePlayer: TLabel;
    lbNameOpponent: TLabel;
    pGameOptions: TPanel;
    sdbtResign: TSpeedButton;
    sdbtDraw: TSpeedButton;
    memNotation: TMemo;
    pMoveOptions: TPanel;
    sdbtToEnding: TSpeedButton;
    sdbtNextMove: TSpeedButton;
    sdbtPrevMove: TSpeedButton;
    sdbtToBegining: TSpeedButton;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FrmAnalysis: TfrmAnalysis;

Implementation

{$R *.dfm}

Uses EnjoyChessDataImages,
    EnjoyChessVCLWelcomeWindow, EnjoyChessInterfaceSound;

Procedure TfrmAnalysis.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    FrmAnalysis.Free;
    FrmWelcomeWindow.Show;
End;

End.
