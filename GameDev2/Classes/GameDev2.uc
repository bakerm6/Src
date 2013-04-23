class GameDev2 extends FrameworkGame;
/*
Game Class for Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
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
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
return Default.class;
}

defaultproperties
{
   PlayerControllerClass=class'GameDev2.GD2PlayerController'
   DefaultPawnClass=class'GameDev2.GD2PlayerPawn'
   HUDType=class'GameDev2.GD2Hud'
   level = SoundCue'Sounds.windc'
   bDelayedStart=false
}

