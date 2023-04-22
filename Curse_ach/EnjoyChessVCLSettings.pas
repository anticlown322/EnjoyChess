Unit EnjoyChessVCLSettings;

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
    Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ColorGrd, VCLTee.TeCanvas;

Type
    TfrmSettings = Class(TForm)
        TreeView1: TTreeView;
    ButtonColor1: TButtonColor;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FrmSettings: TfrmSettings;

Implementation

{$R *.dfm}

Uses EnjoyChessDataImages,
    EnjoyChessVCLWelcomeWindow;

Procedure TfrmSettings.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    FrmSettings.Free;
    FrmWelcomeWindow.Show;
End;

End.
