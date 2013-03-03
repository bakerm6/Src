class GameDev2 extends FrameworkGame;

event PostLogin( PlayerController NewPlayer )
{
 super.PostLogin( NewPlayer );

 NewPlayer.ClientMessage( "Welcome" $ NewPlayer.PlayerReplicationInfo.PlayerName);
}

defaultproperties
{
   PlayerControllerClass=class'GameDev2.GD2PlayerController'
   DefaultPawnClass=class'GameDev2.GD2PlayerPawn'
   HUDType=class'GameDev2.GD2Hud'
   bDelayedStart=false
}