class GameDev2 extends FrameworkGame;
var SoundCue level;
event PostLogin( PlayerController NewPlayer )
{
 super.PostLogin( NewPlayer );
 PlaySound(level);
 SetTimer(43,true,'levelp');
 }
 function levelp()
{
PlaySound(level);
}


defaultproperties
{
   PlayerControllerClass=class'GameDev2.GD2PlayerController'
   DefaultPawnClass=class'GameDev2.GD2PlayerPawn'
   HUDType=class'GameDev2.GD2Hud'
   level = SoundCue'Sounds.windc'
   bDelayedStart=false
}

