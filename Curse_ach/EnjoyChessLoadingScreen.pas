Unit EnjoyChessLoadingScreen;

Interface

Uses
    Windows,
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
    Vcl.ComCtrls,
    EnjoyChessDataImages,
    Vcl.VirtualImage,
    Vcl.Imaging.Pngimage;

Type
    TfrmLoadingScreen = Class(TForm)
        TmrEndLoadingScreen: TTimer;
        TmrAlphaBlendChanging: TTimer;
        ImLogo: TImage;
    lbLogo1: TLabel;
    lbLogo2: TLabel;
        Procedure TmrEndLoadingScreenTimer(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure TmrAlphaBlendChangingTimer(Sender: TObject);
    End;

Var
    FrmLoadingScreen: TfrmLoadingScreen;

Implementation

{$R *.dfm}

Procedure TfrmLoadingScreen.FormCreate(Sender: TObject);
Var
    HRgn: Cardinal;
Begin
    HRgn := CreateEllipticRgn(0, 0, 500, 500);
    SetWindowRgn(Handle, HRgn, False);

    TmrEndLoadingScreen.Enabled := True;
    TmrAlphaBlendChanging.Enabled := True;
End;

Procedure TfrmLoadingScreen.TmrAlphaBlendChangingTimer(Sender: TObject);
Begin
    If FrmLoadingScreen.AlphaBlendValue > 253 Then
        TmrAlphaBlendChanging.Enabled := False
    Else
        FrmLoadingScreen.AlphaBlendValue := FrmLoadingScreen.AlphaBlendValue + 2;
End;

Procedure TfrmLoadingScreen.TmrEndLoadingScreenTimer(Sender: TObject);
Begin
    TmrEndLoadingScreen.Enabled := False;
End;

End.
