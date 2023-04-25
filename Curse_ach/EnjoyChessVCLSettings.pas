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
    Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ColorGrd, VCLTee.TeCanvas,
  EnjoyChessDataImages, EnjoyChessVCLWelcomeWindow;

Type
    TfrmSettings = Class(TForm)
    pBottom: TPanel;
    pgcContent: TPageControl;
    Visual: TTabSheet;
    visualboard: TTabSheet;
    sound: TTabSheet;
    grpbxOptions: TGroupBox;
    rdbVisual: TRadioButton;
    rdbVisualBoard: TRadioButton;
    rdbSound: TRadioButton;
    btcFrontColor: TButtonColor;
    btcBackColor: TButtonColor;
    btcLightColor: TButtonColor;
    btcDarlColor: TButtonColor;
    btcMemoFontColor: TButtonColor;
    trkbVolume: TTrackBar;
    chbxMaximize: TCheckBox;
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

Procedure TfrmSettings.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    FrmSettings.Free;
    FrmWelcomeWindow.Show;
End;

End.
