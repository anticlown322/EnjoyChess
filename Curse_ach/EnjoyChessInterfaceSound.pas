Unit EnjoyChessInterfaceSound;

Interface

{
    Type
        TEnjoyChessSound = Interface
            Procedure StartGame;
            Procedure EndGame;
            Procedure ClickOnPiece;
            Procedure MovePiece;
            Procedure TakePiece;
            Procedure Check;
            Procedure ChessTick;
            Procedure TimeWarning;
        End;

        TEnjoyChessDummySound = Class(TInterfacedObject, TEnjoyChessSound)
            Procedure StartGame;
            Procedure EndGame;
            Procedure ClickOnPiece;
            Procedure MovePiece;
            Procedure TakePiece;
            Procedure Check;
            Procedure TimeWarning;
        End;

        TEnjoyChessStringSound = Class(TInterfacedObject, TEnjoyChessSound)
        Protected
            Procedure PlaySound(Sound: String); Virtual; Abstract;
            Procedure StartGame;
            Procedure EndGame;
            Procedure ClickOnPiece;
            Procedure MovePiece;
            Procedure TakePiece;
            Procedure Check;
            Procedure TimeWarning;
        End;

    Implementation

    // DummySound

    // StringSound

    Procedure TEnjoyChessStringSound.StartGame;
    Begin
        PlaySound('StartGame');
    End;

    Procedure TEnjoyChessStringSound.EndGame;
    Begin
        PlaySound('EndGame');
    End;

    Procedure TEnjoyChessStringSound.ClickOnPiece;
    Begin
        PlaySound('ClickOnPiece');
    End;

    Procedure TEnjoyChessStringSound.MovePiece;
    Begin
        PlaySound('MovePiece');
    End;

    Procedure TEnjoyChessStringSound.TakePiece;
    Begin
        PlaySound('TakePiece');
    End;

    Procedure TEnjoyChessStringSound.Check;
    Begin
        PlaySound('Check');
    End;

    Procedure TEnjoyChessStringSound.TimeWarning;
    Begin
        PlaySound('TimeWarning');
    End;
}

Implementation

End.
