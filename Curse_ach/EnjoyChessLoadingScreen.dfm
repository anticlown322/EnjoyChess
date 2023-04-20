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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object VirtualImage1: TVirtualImage
    Left = 96
    Top = 24
    Width = 400
    Height = 400
    ImageCollection = dtmdData.imcOther
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 2
    ImageName = 'logo'
  end
  object tmrEndLoadingScreen: TTimer
    OnTimer = tmrEndLoadingScreenTimer
    Left = 504
    Top = 24
  end
end
