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
    EnjoyChessDataImages,
    Vcl.Mask;

Type
    TfrmSettings = Class(TForm)
        PBottom: TPanel;
        ChbxMaximize: TCheckBox;
        ScrlbxContent: TScrollBox;
        PSaveConfig: TButton;
        PCancel: TButton;
        PButtons: TPanel;
        PSound: TPanel;
        PVisual: TPanel;
        PBoardVisual: TPanel;
        LbSound: TLabel;
        LbVisual: TLabel;
        LbVisualBoard: TLabel;
        CmbbxSkins: TComboBox;
        LbSkins: TLabel;
        LbLightColor: TLabel;
        LbDarkColor: TLabel;
        ClrbxDarkCell: TColorBox;
        ClrbxLightCell: TColorBox;
        ChkbxSound: TCheckBox;
        LbClock: TLabel;
        PClock: TPanel;
        Label1: TLabel;
        Label2: TLabel;
        MeClockTime: TMaskEdit;
        LbeAddition: TLabeledEdit;
        Label3: TLabel;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure PSaveConfigClick(Sender: TObject);
        Procedure PCancelClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure MeClockTimeChange(Sender: TObject);
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

Procedure TfrmSettings.FormCreate(Sender: TObject);
Var
    SearchResult: TSearchRec;
Begin
    If FindFirst(ExtractFileDir(Extractfilepath(Paramstr(0))) + '\skins\*', FaDirectory, SearchResult) = 0 Then
    Begin
        Repeat
            If ((SearchResult.Attr And FaDirectory) = FaDirectory) And ((SearchResult.Name <> '.') And (SearchResult.Name <> '..')) Then
                CmbbxSkins.Items.Add(SearchResult.Name);
        Until FindNext(SearchResult) <> 0;

        FindClose(SearchResult);
    End;
    CmbbxSkins.Text := FrmWelcomeWindow.Settings.SkinName;
End;

Procedure TfrmSettings.MeClockTimeChange(Sender: TObject);
Begin
    TMaskEdit(Sender).Modified := False;
End;

Procedure TfrmSettings.PCancelClick(Sender: TObject);
Begin
    Close;
End;

Procedure TfrmSettings.PSaveConfigClick(Sender: TObject);
Begin
    If Application.MessageBox(PChar('Вы уверены, что хотите сохранить текущие настройки?'), PChar('Сохранение'),
        MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1 + MB_TASKMODAL) = IDYES Then
    Begin
        FrmWelcomeWindow.Settings.SkinName := CmbbxSkins.Text;
        FrmWelcomeWindow.Settings.LightColor := ClrbxLightCell.Selected;
        FrmWelcomeWindow.Settings.DarkColor := ClrbxDarkCell.Selected;
        FrmWelcomeWindow.Settings.BackColor := $00312E2B;
        FrmWelcomeWindow.Settings.FrontColor := $002B2722;
        FrmWelcomeWindow.Settings.IsWindowMaximized := ChbxMaximize.Checked;
        FrmWelcomeWindow.Settings.SoundsOn := ChkbxSound.Checked;

        If (AnsiPos(' ', MeClockTime.Text) = 0) And (StrToInt(Copy(MeClockTime.Text, 4, 2)) < 60) Then
            FrmWelcomeWindow.Settings.MinAndSecClock := MeClockTime.Text
        Else
        Begin
            ShowMessage('Так были указаны неверные параметры в поле "Время на партию", то было установлено значения по умолчанию - 5 мин. и 0 сек.');
            FrmWelcomeWindow.Settings.MinAndSecClock := '05:00';
        End;

        Try
            If (StrToInt(LbeAddition.Text) > -1) And (StrToInt(LbeAddition.Text) < 61) Then
                FrmWelcomeWindow.Settings.AdditionAfterMove := StrToInt(LbeAddition.Text)
            Else
            Begin
                ShowMessage('Так были указаны неверные параметры в поле "Добавление после хода", то было установлено значения по умолчанию - 0 сек.');
                FrmWelcomeWindow.Settings.AdditionAfterMove := 0;
            End;
        Except
            ShowMessage('Ошибка при считывани в поле "Добавление после хода". Установлено значения по умолчанию - 0 сек.');
            FrmWelcomeWindow.Settings.AdditionAfterMove := 0;
        End;

        Close;
    End;
End;

End.
