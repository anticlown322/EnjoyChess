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
        BtcLightColor: TButtonColor;
        TrkbVolume: TTrackBar;
        ChbxMaximize: TCheckBox;
        ScrlbxContent: TScrollBox;
        PSaveConfig: TButton;
        PCancel: TButton;
        PButtons: TPanel;
        PSound: TPanel;
        PVisual: TPanel;
        PSolver: TPanel;
        PBoardVisual: TPanel;
        LbSolver: TLabel;
        LbSound: TLabel;
        LbVisual: TLabel;
        LbVisualBoard: TLabel;
        CmbbxSkins: TComboBox;
        LbSkins: TLabel;
        LbLightColor: TLabel;
        BtcDarkColor: TButtonColor;
        LbDarkColor: TLabel;
        LbVolume: TLabel;
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure PSaveConfigClick(Sender: TObject);
        Procedure PCancelClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
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
        // FrmWelcomeWindow.Settings.LightColor := BtcLightColor.GetColorProc;
        // FrmWelcomeWindow.Settings.DarkColor := BtcDarkColor.GetColorProc;
        FrmWelcomeWindow.Settings.BackColor := $00312E2B;
        FrmWelcomeWindow.Settings.FrontColor := $002B2722;
        FrmWelcomeWindow.Settings.IsWindowMaximized := ChbxMaximize.Checked;
        FrmWelcomeWindow.Settings.VolumeValue := 50;
        FrmWelcomeWindow.Settings.MemoFontColor := ClWhite;
        Close;
    End;
End;

End.
