object frmAnalysis: TfrmAnalysis
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1077#1078#1080#1084' '#1072#1085#1072#1083#1080#1079#1072
  ClientHeight = 471
  ClientWidth = 894
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object grpBack: TGridPanel
    Left = 0
    Top = 0
    Width = 894
    Height = 471
    Align = alClient
    ColumnCollection = <
      item
        Value = 22.000000000000000000
      end
      item
        Value = 47.000000000000000000
      end
      item
        Value = 31.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = pBoard
        Row = 1
      end
      item
        Column = 0
        Control = pLeft
        Row = 1
      end
      item
        Column = 0
        ColumnSpan = 3
        Control = pTop
        Row = 0
      end
      item
        Column = 2
        Control = pRight
        Row = 1
      end>
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 51.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 0
    object pBoard: TPanel
      Left = 197
      Top = 52
      Width = 419
      Height = 418
      Align = alClient
      Anchors = []
      BevelOuter = bvNone
      Color = 3223083
      ParentBackground = False
      TabOrder = 0
      object pbBoard: TPaintBox
        Left = 22
        Top = 13
        Width = 376
        Height = 376
        Color = 3223083
        ParentColor = False
      end
    end
    object pLeft: TPanel
      Left = 1
      Top = 52
      Width = 196
      Height = 418
      Align = alClient
      BevelOuter = bvNone
      Color = 3223083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object pGameInfo: TPanel
        Left = 13
        Top = 13
        Width = 168
        Height = 203
        Color = 3683890
        ParentBackground = False
        TabOrder = 0
        object lbGameMode: TLabel
          Left = 8
          Top = 7
          Width = 52
          Height = 25
          Caption = #1048#1075#1088#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbWhitePlayerName: TLabel
          Left = 56
          Top = 41
          Width = 68
          Height = 19
          Caption = 'asdffads'
        end
        object viWhiteCircle: TVirtualImage
          Left = 8
          Top = 41
          Width = 34
          Height = 34
          ImageCollection = dtmdData.imcOther
          ImageWidth = 0
          ImageHeight = 0
          ImageIndex = 1
          ImageName = 'white-circle'
        end
        object viBlackCircle: TVirtualImage
          Left = 13
          Top = 79
          Width = 24
          Height = 24
          ImageCollection = dtmdData.imcOther
          ImageWidth = 0
          ImageHeight = 0
          ImageIndex = 0
          ImageName = 'black-circle'
        end
        object lbBlackPlayerName: TLabel
          Left = 56
          Top = 79
          Width = 42
          Height = 19
          Caption = 'adfdf'
        end
      end
      object splvMenu: TSplitView
        Left = 0
        Top = 0
        Width = 0
        Height = 418
        Color = 2828066
        Opened = False
        OpenedWidth = 200
        Placement = svpLeft
        TabOrder = 1
        object pMenuButtonSettings: TPanel
          Left = 0
          Top = 82
          Width = 0
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
          Color = 2828066
          ParentBackground = False
          TabOrder = 0
        end
        object pMenuButtonAnalysis: TPanel
          Left = 0
          Top = 41
          Width = 0
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = #1040#1085#1072#1083#1080#1079
          Color = 2828066
          ParentBackground = False
          TabOrder = 1
        end
        object pMenuButtonSave: TPanel
          Left = 0
          Top = 0
          Width = 0
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          Color = 2828066
          ParentBackground = False
          TabOrder = 2
        end
        object pMenuButtonBackToWelcome: TPanel
          Left = 0
          Top = 123
          Width = 0
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = #1052#1077#1085#1102
          Color = 2828066
          ParentBackground = False
          TabOrder = 3
        end
      end
    end
    object pTop: TPanel
      Left = 1
      Top = 1
      Width = 892
      Height = 51
      Align = alClient
      BevelOuter = bvNone
      Color = 2828066
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object viMenuBar: TVirtualImage
        Left = 5
        Top = 1
        Width = 48
        Height = 48
        ImageCollection = dtmdData.imcForButtons
        ImageWidth = 0
        ImageHeight = 0
        ImageIndex = 11
        ImageName = 'Menus\menu-white'
      end
      object lbUsername: TLabel
        Left = 795
        Top = 11
        Width = 76
        Height = 29
        Alignment = taRightJustify
        Caption = 'dafadf'
      end
    end
    object pRight: TPanel
      Left = 616
      Top = 52
      Width = 277
      Height = 418
      Align = alClient
      BevelOuter = bvNone
      Color = 3223083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      object lbTimeOpponent: TLabel
        Left = 16
        Top = 7
        Width = 101
        Height = 42
        Caption = '00:00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -35
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbTimePlayer: TLabel
        Left = 16
        Top = 337
        Width = 101
        Height = 42
        Caption = '00:00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -35
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbnNamePlayer: TLabel
        Left = 16
        Top = 302
        Width = 90
        Height = 29
        Caption = 'Adfadsf'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbNameOpponent: TLabel
        Left = 16
        Top = 55
        Width = 61
        Height = 29
        Caption = 'Afdsf'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pGameOptions: TPanel
        Left = 14
        Top = 256
        Width = 240
        Height = 32
        BevelOuter = bvNone
        Color = 3683890
        ParentBackground = False
        TabOrder = 0
        object sdbtResign: TSpeedButton
          Left = 32
          Top = 0
          Width = 32
          Height = 32
          Align = alLeft
          Flat = True
          ExplicitLeft = 40
          ExplicitHeight = 41
        end
        object sdbtDraw: TSpeedButton
          Left = 0
          Top = 0
          Width = 32
          Height = 32
          Align = alLeft
          Flat = True
          ExplicitLeft = 40
          ExplicitHeight = 41
        end
      end
      object memNotation: TMemo
        Left = 14
        Top = 130
        Width = 240
        Height = 127
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 2499617
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Lines.Strings = (
          '')
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object pMoveOptions: TPanel
        Left = 14
        Top = 99
        Width = 240
        Height = 32
        BevelOuter = bvNone
        Color = 3683890
        ParentBackground = False
        TabOrder = 2
        object sdbtToEnding: TSpeedButton
          Left = 96
          Top = 0
          Width = 32
          Height = 32
          Align = alLeft
          Flat = True
          ExplicitLeft = 144
          ExplicitTop = -7
        end
        object sdbtNextMove: TSpeedButton
          Left = 64
          Top = 0
          Width = 32
          Height = 32
          Align = alLeft
          Flat = True
          ExplicitLeft = 8
        end
        object sdbtPrevMove: TSpeedButton
          Left = 32
          Top = 0
          Width = 32
          Height = 32
          Align = alLeft
          Flat = True
          ExplicitLeft = 8
        end
        object sdbtToBegining: TSpeedButton
          Left = 0
          Top = 0
          Width = 32
          Height = 32
          Align = alLeft
          Flat = True
          ExplicitTop = -5
        end
      end
    end
  end
  object Timer1: TTimer
    Left = 649
    Top = 129
  end
end
