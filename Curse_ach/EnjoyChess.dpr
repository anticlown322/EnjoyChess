program EnjoyChess;

uses
  Vcl.Forms,
  StageWelcome in 'StageWelcome.pas' {Form1},
  Data in 'Data.pas' {DataModule1: TDataModule},
  StageAnalysis in 'StageAnalysis.pas' {Form2},
  StageGame in 'StageGame.pas' {Form3},
  Explorer in 'Explorer.pas' {Form4},
  Solver in 'Solver.pas',
  CheckMoves in 'CheckMoves.pas',
  ProvideMoves in 'ProvideMoves.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
