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
    Vcl.ComCtrls, EnjoyChessDataImages, Vcl.VirtualImage, Vcl.Imaging.pngimage;

Type
    TfrmLoadingScreen = Class(TForm)
        TmrEndLoadingScreen: TTimer;
    imLogo: TImage;
        Procedure TmrEndLoadingScreenTimer(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
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
End;

Procedure TfrmLoadingScreen.TmrEndLoadingScreenTimer(Sender: TObject);
Begin
    TmrEndLoadingScreen.Enabled := False;
End;

End.
