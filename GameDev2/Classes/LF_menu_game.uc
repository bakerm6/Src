class LF_menu_game extends SimpleGame;
/*
Menu Game Class for Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

var LF_Main_Menu main;
var SoundCue main_menu_music;



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
	PlaySound(main_menu_music);
	SetTimer(41.5,true,'loop_music');
	
 }
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return Default.class;
}

function loop_music()
{
	PlaySound(main_menu_music);
}
defaultproperties
{
   PlayerControllerClass=class'GameDev2.LF_PC_Menu'
   DefaultPawnClass=class'GameDev2.LF_Pawn_Menu'
  // HUDType=class'GameDev2.LF_Menu_HUD'
   bDelayedStart=false
   main_menu_music = Soundcue'Sounds.title_take_2'
}