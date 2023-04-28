Unit EnjoyChessDataImages;

Interface

Uses
  System.SysUtils,
  System.Classes,
  Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.Controls;

Type
  TdtmdData = Class(TDataModule)
    ImcIcons: TImageCollection;
    ImcForButtons: TImageCollection;
    imcOther: TImageCollection;
  End;

Var
  DtmdDataImages: TdtmdData;

Implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

End.
