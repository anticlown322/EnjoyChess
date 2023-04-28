object frmPromotion: TfrmPromotion
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1078#1077#1083#1072#1077#1084#1091#1102' '#1092#1080#1075#1091#1088#1091
  ClientHeight = 181
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pButtons: TPanel
    Left = 0
    Top = 0
    Width = 650
    Height = 181
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 671
    ExplicitHeight = 171
    object sdbtKnightChoice: TSpeedButton
      AlignWithMargins = True
      Left = 481
      Top = 0
      Width = 170
      Height = 181
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Images = vilImages
      OnClick = sdbtKnightChoiceClick
      ExplicitLeft = 483
      ExplicitWidth = 160
    end
    object sdbtBishopChoice: TSpeedButton
      AlignWithMargins = True
      Left = 321
      Top = 0
      Width = 160
      Height = 181
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Images = vilImages
      OnClick = sdbtBishopChoiceClick
      ExplicitLeft = 323
    end
    object sdbtRookChoice: TSpeedButton
      AlignWithMargins = True
      Left = 160
      Top = 0
      Width = 161
      Height = 181
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Images = vilImages
      OnClick = sdbtRookChoiceClick
    end
    object sdbtQueenChoice: TSpeedButton
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 160
      Height = 181
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Images = vilImages
      OnClick = sdbtQueenChoiceClick
      ExplicitLeft = -5
      ExplicitHeight = 169
    end
  end
  object vilImages: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 12
        CollectionName = 'PromotionChoices\bB'
        Disabled = False
        Name = 'bB'
      end
      item
        CollectionIndex = 13
        CollectionName = 'PromotionChoices\bN'
        Disabled = False
        Name = 'bN'
      end
      item
        CollectionIndex = 14
        CollectionName = 'PromotionChoices\bQ'
        Disabled = False
        Name = 'bQ'
      end
      item
        CollectionIndex = 15
        CollectionName = 'PromotionChoices\bR'
        Disabled = False
        Name = 'bR'
      end
      item
        CollectionIndex = 16
        CollectionName = 'PromotionChoices\wB'
        Disabled = False
        Name = 'wB'
      end
      item
        CollectionIndex = 17
        CollectionName = 'PromotionChoices\wN'
        Disabled = False
        Name = 'wN'
      end
      item
        CollectionIndex = 18
        CollectionName = 'PromotionChoices\wQ'
        Disabled = False
        Name = 'wQ'
      end
      item
        CollectionIndex = 19
        CollectionName = 'PromotionChoices\wR'
        Disabled = False
        Name = 'wR'
      end>
    ImageCollection = dtmdData.imcForButtons
    Width = 80
    Height = 80
    Left = 600
    Top = 8
  end
end
