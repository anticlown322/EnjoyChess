Unit EnjoyChessVCLWelcomeWindow;

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
    Vcl.ExtCtrls,
    Vcl.StdCtrls,
    System.ImageList,
    Vcl.ImgList,
    Vcl.VirtualImageList,
    Vcl.Buttons,
    Vcl.Imaging.Pngimage,
    ShellApi,
    VCLTee.TeCanvas,
    Vcl.ButtonGroup,
    VCLTee.TeeEdiGrad,
    Vcl.CategoryButtons,
    Vcl.ControlList,
    EnjoyChessDataImages,
    EnjoyChessSettings,
    EnjoyChessVCLSettings;

Type
    TfrmWelcomeWindow = Class(TForm)
        PBottom: TPanel;
        PButtons: TPanel;
        OpdOpenFromFile: TOpenDialog;
        PClient: TPanel;
        BbtStartGame: TBitBtn;
        BbtStartAnalysis: TBitBtn;
        BbtLoadGame: TBitBtn;
        BbtGoToSettings: TBitBtn;
        BbtExit: TBitBtn;
        VilImages_48: TVirtualImageList;
        LbMenu: TLabel;
        SdbtStartGame: TSpeedButton;
        SdbtAnalysis: TSpeedButton;
        SpbtOpen: TSpeedButton;
        SdbtSettings: TSpeedButton;
        SdbtHelp: TSpeedButton;
        SdbtBoardEditor: TSpeedButton;
        SdbtProfile: TSpeedButton;
        SdbtExit: TSpeedButton;
        ImGitHubIcon: TImage;
        ImVKIcon: TImage;
        ImLinkedInIcon: TImage;
        ImInstagramIcon: TImage;
        ImTelegramIcon: TImage;
        BlhBalloonHint: TBalloonHint;
        Procedure ImGitHubIconClick(Sender: TObject);
        Procedure ImInstagramIconClick(Sender: TObject);
        Procedure ImLinkedInIconClick(Sender: TObject);
        Procedure ImTelegramIconClick(Sender: TObject);
        Procedure ImVKIconClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure SdbtExitClick(Sender: TObject);
        Procedure BbtExitClick(Sender: TObject);
        Procedure BbtStartGameClick(Sender: TObject);
        Procedure BbtStartAnalysisClick(Sender: TObject);
        Procedure BbtGoToSettingsClick(Sender: TObject);
        Procedure SdbtSettingsClick(Sender: TObject);
        Procedure SdbtAnalysisClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormDestroy(Sender: TObject);
        Procedure SdbtBoardEditorClick(Sender: TObject);
        Procedure SdbtProfileClick(Sender: TObject);
    Public
        Settings: TSettings;
    End;

Var
    FrmWelcomeWindow: TfrmWelcomeWindow;

Implementation

{$R *.dfm}

Uses
    EnjoyChessVCLGameForm;

Procedure TfrmWelcomeWindow.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
    If Application.MessageBox(PChar('Вы уверены, что хотите выйти?'), PChar('Выход'), MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1 + MB_TASKMODAL)
        = IDYES Then
        Application.Terminate
    Else
        CanClose := False;
End;

Procedure TfrmWelcomeWindow.FormCreate(Sender: TObject);
Begin
    Settings := TSettings.Create;
End;

Procedure TfrmWelcomeWindow.FormDestroy(Sender: TObject);
Begin
    Settings.Free;
End;

// Нажатие иконок соцсетей

Procedure TfrmWelcomeWindow.ImGitHubIconClick(Sender: TObject);
Begin
    ShellExecute(Handle, 'open', 'https://github.com/anticlown322/EnjoyChess', Nil, Nil, SW_SHOW);
End;

Procedure TfrmWelcomeWindow.ImInstagramIconClick(Sender: TObject);
Begin
    ShellExecute(Handle, 'open', 'https://www.instagram.com/default_clownfish', Nil, Nil, SW_SHOW);
End;

Procedure TfrmWelcomeWindow.ImLinkedInIconClick(Sender: TObject);
Begin
    ShellExecute(Handle, 'open', 'https://www.linkedin.com/in/andrey-karas', Nil, Nil, SW_SHOW);
End;

Procedure TfrmWelcomeWindow.ImTelegramIconClick(Sender: TObject);
Begin
    ShellExecute(Handle, 'open', 'https://t.me/fksis', Nil, Nil, SW_SHOW);
End;

Procedure TfrmWelcomeWindow.ImVKIconClick(Sender: TObject);
Begin
    ShellExecute(Handle, 'open', 'https://vk.com/clown_fish_leader', Nil, Nil, SW_SHOW);
End;

// Нажатие кнопок на боковой панели

Procedure TfrmWelcomeWindow.SdbtExitClick(Sender: TObject);
Begin
    BbtExitClick(Sender);
End;

Procedure TfrmWelcomeWindow.SdbtProfileClick(Sender: TObject);
Begin
    ShowMessage('Эта функция будет доступна в следующей версии.');
End;

Procedure TfrmWelcomeWindow.SdbtSettingsClick(Sender: TObject);
Begin
    BbtGoToSettingsClick(Sender);
End;

Procedure TfrmWelcomeWindow.SdbtAnalysisClick(Sender: TObject);
Begin
    ShowMessage('Эта функция будет доступна в следующей версии.');
    // BbtStartAnalysisClick(Sender);
End;

Procedure TfrmWelcomeWindow.SdbtBoardEditorClick(Sender: TObject);
Begin
    ShowMessage('Эта функция будет доступна в следующей версии.');
End;

// Нажатие кнопок в клиенте

Procedure TfrmWelcomeWindow.BbtExitClick(Sender: TObject);
Begin
    FrmWelcomeWindow.Close;
End;

Procedure TfrmWelcomeWindow.BbtGoToSettingsClick(Sender: TObject);
Begin
    FrmSettings := TfrmSettings.Create(Self);
    FrmWelcomeWindow.Hide;
    FrmSettings.Show;
End;

Procedure TfrmWelcomeWindow.BbtStartAnalysisClick(Sender: TObject);
Begin
    ShowMessage('Эта функция будет доступна в следующей версии.');
    {
      FrmAnalysis := TFrmAnalysis.Create(Self);
      FrmWelcomeWindow.Hide;
      FrmAnalysis.Show;
    }
End;

Procedure TfrmWelcomeWindow.BbtStartGameClick(Sender: TObject);
Begin
    FrmGameForm := TfrmGameForm.Create(Self);
    FrmWelcomeWindow.Hide;
    FrmGameForm.Show;
End;

End.
