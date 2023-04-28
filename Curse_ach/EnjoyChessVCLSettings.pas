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
    Vcl.ComCtrls,
    Vcl.ExtCtrls,
    Vcl.StdCtrls,
    Vcl.ColorGrd,
    VCLTee.TeCanvas,
    EnjoyChessDataImages;

Type
    TfrmSettings = Class(TForm)
        PBottom: TPanel;
        GrpbxOptions: TGroupBox;
        RdbVisual: TRadioButton;
        RdbVisualBoard: TRadioButton;
        RdbSound: TRadioButton;
        BtcFrontColor: TButtonColor;
        BtcBackColor: TButtonColor;
        BtcLightColor: TButtonColor;
        BtcDarlColor: TButtonColor;
        BtcMemoFontColor: TButtonColor;
        TrkbVolume: TTrackBar;
        ChbxMaximize: TCheckBox;
        ScrlbxContent: TScrollBox;
        Button1: TButton;
        Button2: TButton;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    End;

Var
    FrmSettings: TfrmSettings;

Implementation

{$R *.dfm}

Uses EnjoyChessVCLWelcomeWindow;

Procedure TfrmSettings.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    FrmSettings.Free;
    FrmWelcomeWindow.Show;
End;

End.
