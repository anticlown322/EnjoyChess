Program EnjoyChess;

uses
  Vcl.Forms,
  EnjoyChessVCLWelcomeWindow in 'EnjoyChessVCLWelcomeWindow.pas' {frmWelcomeWindow},
  EnjoyChessDataImages in 'EnjoyChessDataImages.pas' {dtmdData: TDataModule},
  EnjoyChessVCLAnalysis in 'EnjoyChessVCLAnalysis.pas' {frmAnalysis},
  EnjoyChessVCLGameForm in 'EnjoyChessVCLGameForm.pas' {frmGameForm},
  EnjoyChessVCLSettings in 'EnjoyChessVCLSettings.pas' {frmSettings},
  Vcl.Themes,
  Vcl.Styles,
  EnjoyChessBackEngine in 'EnjoyChessBackEngine.pas',
  EnjoyChessLoadingScreen in 'EnjoyChessLoadingScreen.pas' {frmLoadingScreen},
  EnjoyChessSettings in 'EnjoyChessSettings.pas',
  EnjoyChessSound in 'EnjoyChessSound.pas',
  EnjoyChessVCLPawnPromotion in 'EnjoyChessVCLPawnPromotion.pas' {frmPromotion};

{$R *.res}

Begin
    Application.Initialize;

    FrmLoadingScreen := TfrmLoadingScreen.Create(Application);
    FrmLoadingScreen.Show;
    While FrmLoadingScreen.TmrEndLoadingScreen.Enabled Do
        Application.ProcessMessages;
    FrmLoadingScreen.Hide;

    Application.MainFormOnTaskbar := False;
    Application.CreateForm(TFrmWelcomeWindow, FrmWelcomeWindow);
  Application.CreateForm(TfrmPromotion, frmPromotion);
  FrmLoadingScreen.Free;
    Application.CreateForm(TDtmdData, DtmdDataImages);
    Application.Run;

End.
