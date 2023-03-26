Program EnjoyChess;

uses
  Vcl.Forms,
  EnjoyChessVCLWelcomeWindow in 'EnjoyChessVCLWelcomeWindow.pas' {frmWelcomeWindow},
  EnjoyChessDataModule in 'EnjoyChessDataModule.pas' {dtmdData: TDataModule},
  EnjoyChessVCLAnalysis in 'EnjoyChessVCLAnalysis.pas' {frmAnalysis},
  EnjoyChessVCLGameForm in 'EnjoyChessVCLGameForm.pas' {frmGameForm},
  EnjoyChessVCLExplorer in 'EnjoyChessVCLExplorer.pas' {frmExplorer},
  EnjoyChessSolver in 'EnjoyChessSolver.pas',
  EnjoyChessVCLSettings in 'EnjoyChessVCLSettings.pas' {frmSettings},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := False;
    Application.CreateForm(TFrmWelcomeWindow, FrmWelcomeWindow);
  Application.CreateForm(TDtmdData, DtmdData);
  Application.Run;
End.
