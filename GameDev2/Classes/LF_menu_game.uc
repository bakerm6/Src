class LF_menu_game extends SimpleGame;
/*
Menu Game Class for Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
var LF_Main_Menu main;

///////////////////////////////////////////////

event PostLogin( PlayerController NewPlayer )
{
 super.PostLogin( NewPlayer );
 //main = new class'LF_Main_Menu';
 //main.Init();
 }
 simulated function StartMatch()
 {
	super.StartMatch();
	main = new class'LF_Main_Menu';
	//main.SetTimingMode(TM_Real);
	main.Init();
 
 }
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
return Default.class;
}

defaultproperties
{
	PlayerControllerClass=class'GameDev2.LF_PC_Menu'
   DefaultPawnClass=class'GameDev2.LF_Pawn_Menu'
  // HUDType=class'GameDev2.LF_Menu_HUD'
   bDelayedStart=false
}