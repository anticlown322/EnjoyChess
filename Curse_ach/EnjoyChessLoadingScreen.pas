Unit EnjoyChessLoadingScreen;

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
    Vcl.StdCtrls,
    Vcl.ExtCtrls,
    Vcl.ComCtrls;

Type
    TfrmLoadingScreen = Class(TForm)
        Label1: TLabel;
        TmrEndLoadingScreen: TTimer;
        PrgbLoadingBar: TProgressBar;
        TmrLoadingBar: TTimer;
        Procedure TmrEndLoadingScreenTimer(Sender: TObject);
        Procedure TmrLoadingBarTimer(Sender: TObject);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FrmLoadingScreen: TfrmLoadingScreen;

Implementation

{$R *.dfm}

Procedure TfrmLoadingScreen.TmrLoadingBarTimer(Sender: TObject);
Begin
    If PrgbLoadingBar.Position < PrgbLoadingBar.Max - PrgbLoadingBar.Step Then
        PrgbLoadingBar.StepIt
    Else
    Begin
        PrgbLoadingBar.StepIt;
        TmrLoadingBar.Enabled := False;
    End;
End;

Procedure TfrmLoadingScreen.TmrEndLoadingScreenTimer(Sender: TObject);
Begin
    TmrEndLoadingScreen.Enabled := False;
End;

End.
