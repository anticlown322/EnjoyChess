program EnjoyChess;

uses
  Vcl.Forms,
  EnjoyChessVCLWelcomeWindow in 'EnjoyChessVCLWelcomeWindow.pas' {frmWelcomeWindow},
  EnjoyChessDataModule in 'EnjoyChessDataModule.pas' {dtmdData: TDataModule},
  EnjoyChessVCLAnalysis in 'EnjoyChessVCLAnalysis.pas' {frmAnalysis},
  EnjoyChessVCLGameForm in 'EnjoyChessVCLGameForm.pas' {frmGameForm},
  EnjoyChessVCLExplorer in 'EnjoyChessVCLExplorer.pas' {frmExplorer},
  EnjoyChessSolver in 'EnjoyChessSolver.pas',
  EnjoyChessCheckMoves in 'EnjoyChessCheckMoves.pas',
  EnjoyChessSounds in 'EnjoyChessSounds.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcomeWindow, frmWelcomeWindow);
  Application.CreateForm(TdtmdData, dtmdData);
  Application.CreateForm(TfrmAnalysis, frmAnalysis);
  Application.CreateForm(TfrmGameForm, frmGameForm);
  Application.CreateForm(TfrmExplorer, frmExplorer);
  Application.Run;
end.
