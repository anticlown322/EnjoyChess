Unit EnjoyChessSound;

Interface

Uses Mmsystem;

Type
    TEnjoyChessSound = Class
    Private
        Ending: String;
        Move: String;
        Take: String;
        Procedure AddSounds();
    Public
        Property GameEndSound: String Read Ending Write Ending;
        Property MoveSound: String Read Move Write Move;
        Property TakeSound: String Read Take Write Take;
        Procedure PlaySnd(Sound: String);
        Constructor Create();
    End;

Implementation

{ TEnjoyChessSound }

Constructor TEnjoyChessSound.Create();
Begin
    AddSounds();
End;

Procedure TEnjoyChessSound.AddSounds();
Begin
    Ending := 'sounds\gameends.wav';
    Move := 'sounds\move.wav';
    Take := 'sounds\take.wav';
End;

Procedure TEnjoyChessSound.PlaySnd(Sound: String);
Begin
   PlaySound (PChar(Sound), 0, SND_ASYNC);
End;

End.
