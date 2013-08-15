class LF_PauseMenu extends GFxMoviePlayer;
/*
Pause menu movie class for landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
//initialize variables
var GFxObject  RootMC;
var GFxObject progress, mission, objective;
var LF_save_info save_ob;
var bool bIsOpen;
//Starts the movie
function bool Start(optional bool StartPaused = false)
{
		local actor Player_Location_Actor;
		local GD2PlayerPawn LF_pawn;
        super.Start();
		bIsOpen = true;
		Player_Location_Actor = GetPC().Pawn;
		LF_pawn = GD2PlayerPawn(Player_Location_Actor);
        Advance(0);
        RootMC = GetVariableObject("_root");
		progress = GetVariableObject("_root.p_perc");
		mission = GetVariableObject("_root.c_mis");
		objective = GetVariableObject("_root.m_obj");
		if(LF_Pawn.mission1 == true && LF_Pawn.mission2a == false)
		{
			progress.SetText("5%");
			mission.SetText("Gather Supplies");
			objective.SetText("It looks like I won't be leaving\n anytime soon.\n I better find some food, water,\n and some batteries to get this\n flashlight working.");
		}
		if(LF_Pawn.mission1 == true && LF_Pawn.mission2a == True && LF_Pawn.mission2b == false)
		{
			progress.SetText("10%");
			mission.SetText("Find a Telephone");
			objective.SetText("I need to call for help.\n A phone should work as long\n the line is connected.\n Maybe I should check the\n Fun House.");
		}
		if(LF_Pawn.mission1 == true && LF_Pawn.mission2a == True && LF_Pawn.mission2b == True && LF_Pawn.mission3 == false)
		{
			progress.SetText("15%");
			mission.SetText("Repair the Telephone");
			objective.SetText("This phone seems fixable..\n I'm going to need\n Wire Strippers\n Duct Tape\n and some Copper Wire.");
		}
        return true;
} 
function save_game_info()
{
	local actor Player_Location_Actor;
    local GD2PlayerPawn LF_pawn;
	Player_Location_Actor = GetPC().Pawn;
    LF_pawn = GD2PlayerPawn(Player_Location_Actor);
	save_ob = class'LF_save_info'.static.load_options();
	if(save_ob == none)
	{
		save_ob = new class'LF_save_info';
	}
	save_ob.mission_1 = LF_Pawn.mission1;
	save_ob.mission_2 = LF_Pawn.mission2a;
	save_ob.mission_3 = LF_Pawn.mission3;
	save_ob.mission_4 = LF_Pawn.mission4;
	save_ob.mission_5 = LF_Pawn.mission5;
	save_ob.flashlight_state = LF_Pawn.flashlightc;
	save_ob.loc_x = LF_Pawn.location.X;
	save_ob.loc_y = LF_Pawn.location.Y;
	save_ob.loc_z = LF_Pawn.location.Z;
	save_ob.map_name = GetPC().WorldInfo.GetMapName();
	save_ob.save_game();
	/*`log(save_ob.mission_1);
	`log(save_ob.mission_2);
	`log(save_ob.mission_3);
	`log(save_ob.mission_4);
	`log(save_ob.mission_5);
	`log(save_ob.flashlight_state);
	`log(save_ob.loc_x);
	`log(save_ob.loc_y);
	`log(save_ob.loc_z);
	`log(save_ob.map_name);*/
}
function End()
{
	bIsOpen = false;
	Close();
}
function open_main_menu()
{
	ConsoleCommand("open betamen_1");
}
defaultproperties
{
    bEnableGammaCorrection=FALSE
	bPauseGameWhileActive=True
	bIgnoreMouseInput = false
	bCaptureInput=False
	bIsOpen = false
}
