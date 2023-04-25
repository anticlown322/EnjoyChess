Unit EnjoyChessSettings;

Interface

Uses EnjoyChessVCLSettings,
    Graphics;

Type
    TSettings = Class
    Private
        Skin: String;
        Light: TColor;
        Dark: TColor;
        Back: TColor;
        Front: TColor;
        IsMaximized: Boolean;
        Volume: Integer;
        MemFColor: TColor;
    Protected
        Function GetSkinName(): String;
        Procedure SetSkinName(Value: String);
        Function GetLightColor(): TColor;
        Procedure SetLightColor(Value: TColor);
        Function GetDarkColor(): TColor;
        Procedure SetDarkColor(Value: TColor);
        Function GetBackColor(): TColor;
        Procedure SetBackColor(Value: TColor);
        Function GetFrontColor(): TColor;
        Procedure SetFrontColor(Value: TColor);
        Function GetWindowState(): Boolean;
        Procedure SetWindowState(Value: Boolean);
        Function GetVolumeValue(): Integer;
        Procedure SetVolumeValue(Value: Integer);
        Function GetMemoFontColor(): TColor;
        Procedure SetMemoFontColor(Value: TColor);
    Public
        Property SkinName: String Read GetSkinName Write SetSkinName;
        Property LightColor: TColor Read GetLightColor Write SetLightColor;
        Property DarkColor: TColor Read GetDarkColor Write SetDarkColor;
        Property BackColor: TColor Read GetBackColor Write SetBackColor;
        Property FrontColor: TColor Read GetFrontColor Write SetFrontColor;
        Property IsWindowMaximized: Boolean Read GetWindowState Write SetWindowState;
        Property VolumeValue: Integer Read GetVolumeValue Write SetVolumeValue;
        Property MemoFontColor: TColor Read GetMemoFontColor Write SetMemoFontColor;
        Constructor Create();
    End;

Implementation

Constructor TSettings.Create();
Begin
    SkinName := 'chesscom';
    LightColor := $E5D3B3;
    DarkColor := $B58863;
    BackColor := $00312E2B;
    FrontColor := $002B2722;
    IsWindowMaximized := True;
    Volume := 50;
    MemoFontColor := ClWhite;
End;

Procedure TSettings.SetSkinName(Value: String);
Begin
    Skin := Value;
End;

Function TSettings.GetSkinName(): String;
Begin
    GetSkinName := Skin;
End;

Procedure TSettings.SetLightColor(Value: TColor);
Begin
    Light := Value;
End;

Function TSettings.GetLightColor(): TColor;
Begin
    GetLightColor := Light;
End;

Procedure TSettings.SetDarkColor(Value: TColor);
Begin
    Dark := Value;
End;

Function TSettings.GetDarkColor(): TColor;
Begin
    GetDarkColor := Dark;
End;

Procedure TSettings.SetBackColor(Value: TColor);
Begin
    Back := Value;
End;

Function TSettings.GetBackColor(): TColor;
Begin
    GetBackColor := Back;
End;

Procedure TSettings.SetFrontColor(Value: TColor);
Begin
    Front := Value;
End;

Function TSettings.GetFrontColor(): TColor;
Begin
    GetFrontColor := Front;
End;

Procedure TSettings.SetWindowState(Value: Boolean);
Begin
    IsMaximized := Value;
End;

Function TSettings.GetWindowState(): Boolean;
Begin
    GetWindowState := IsMaximized;
End;

Procedure TSettings.SetVolumeValue(Value: Integer);
Begin
    Volume := Value;
End;

Function TSettings.GetVolumeValue(): Integer;
Begin
    GetVolumeValue := Volume;
End;

Procedure TSettings.SetMemoFontColor(Value: TColor);
Begin
    MemFColor := Value;
End;

Function TSettings.GetMemoFontColor(): TColor;
Begin
    GetMemoFontColor := MemFColor;
End;

End.
