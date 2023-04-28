Unit EnjoyChessVCLPawnPromotion;

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
    Vcl.Buttons,
    EnjoyChessDataImages,
    System.ImageList,
    Vcl.ImgList,
    Vcl.VirtualImageList,
    EnjoyChessBackEngine;

Type

    PClass = ^TClass;

    TfrmPromotion = Class(TForm)
        SdbtKnightChoice: TSpeedButton;
        PButtons: TPanel;
        SdbtBishopChoice: TSpeedButton;
        SdbtRookChoice: TSpeedButton;
        SdbtQueenChoice: TSpeedButton;
        VilImages: TVirtualImageList;
        Procedure FormCreate(Sender: TObject);
        Procedure SdbtQueenChoiceClick(Sender: TObject);
        Procedure SdbtRookChoiceClick(Sender: TObject);
        Procedure SdbtBishopChoiceClick(Sender: TObject);
        Procedure SdbtKnightChoiceClick(Sender: TObject);
    Public
        IsWhite: Boolean;
        PieceType: TPiece;
    End;

Var
    FrmPromotion: TfrmPromotion;

Implementation

{$R *.dfm}

Procedure TfrmPromotion.FormCreate(Sender: TObject);
Begin
    If IsWhite Then
    Begin
        SdbtQueenChoice.ImageName := 'wQ';
        SdbtRookChoice.ImageName := 'wR';
        SdbtBishopChoice.ImageName := 'wB';
        SdbtKnightChoice.ImageName := 'wN';
    End
    Else
    Begin
        SdbtQueenChoice.ImageName := 'bQ';
        SdbtRookChoice.ImageName := 'bR';
        SdbtBishopChoice.ImageName := 'bB';
        SdbtKnightChoice.ImageName := 'bN';
    End;
End;

Procedure TfrmPromotion.SdbtBishopChoiceClick(Sender: TObject);
Begin
    PClass(PieceType)^ := TBishop;
    Close;
End;

Procedure TfrmPromotion.SdbtKnightChoiceClick(Sender: TObject);
Begin
    PClass(PieceType)^  := TNKnight;
    Close;
End;

Procedure TfrmPromotion.SdbtQueenChoiceClick(Sender: TObject);
Begin
    PClass(PieceType)^  := TQueen;
    Close;
End;

Procedure TfrmPromotion.SdbtRookChoiceClick(Sender: TObject);
Begin
    PClass(PieceType)^  := TRook;
    Close;
End;

End.
