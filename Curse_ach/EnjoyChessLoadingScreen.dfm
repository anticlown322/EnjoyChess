object frmLoadingScreen: TfrmLoadingScreen
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 466
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 192
    Top = 256
    Width = 184
    Height = 25
    Caption = #1044#1086#1073#1088#1086' '#1055#1086#1078#1072#1083#1086#1074#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object prgbLoadingBar: TProgressBar
    Left = 192
    Top = 320
    Width = 184
    Height = 25
    Smooth = True
    SmoothReverse = True
    TabOrder = 0
  end
  object tmrEndLoadingScreen: TTimer
    Interval = 100
    OnTimer = tmrEndLoadingScreenTimer
    Left = 504
    Top = 24
  end
  object tmrLoadingBar: TTimer
    Interval = 500
    OnTimer = tmrLoadingBarTimer
    Left = 504
    Top = 72
  end
end
