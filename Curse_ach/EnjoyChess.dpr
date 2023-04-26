Program EnjoyChess;

Uses
    Vcl.Forms,
    EnjoyChessVCLWelcomeWindow In 'EnjoyChessVCLWelcomeWindow.pas' {frmWelcomeWindow} ,
    EnjoyChessDataImages In 'EnjoyChessDataImages.pas' {dtmdData: TDataModule} ,
    EnjoyChessVCLAnalysis In 'EnjoyChessVCLAnalysis.pas' {frmAnalysis} ,
    EnjoyChessVCLGameForm In 'EnjoyChessVCLGameForm.pas' {frmGameForm} ,
    EnjoyChessVCLSettings In 'EnjoyChessVCLSettings.pas' {frmSettings} ,
    Vcl.Themes,
    Vcl.Styles,
    EnjoyChessBackEngine In 'EnjoyChessBackEngine.pas',
    EnjoyChessLoadingScreen In 'EnjoyChessLoadingScreen.pas' {frmLoadingScreen} ,
    EnjoyChessSettings In 'EnjoyChessSettings.pas',
    EnjoyChessSound In 'EnjoyChessSound.pas';

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
    FrmLoadingScreen.Free;
    Application.CreateForm(TDtmdData, DtmdDataImages);
    Application.Run;

End.
