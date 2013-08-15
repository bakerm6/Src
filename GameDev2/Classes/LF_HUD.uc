class LF_HUD extends HUD;
/*
HUD class for Landfall
contains exec functions for returning to main menu
renders pause menu
renders text prompts for all missions
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var LF_PauseMenu PauseMenu;
var bool x;
var bool player_m_1, player_obj_1, player_m_2;
var(Rendertext) Font lf;
var LF_Menu_Prompt menu_prompt;
var LF_Main_Menu main_menu;
var LF_Mission1_Description mission1_mov;
var LF_Mission1_Objective_Movie mission1_objc_mov;
var LF_Mission2_Description mission2_mov;
var LF_Heart_HUD h_HUD;
var GFxObject obj_movie;
var bool mission1_objc_mov_end_bool;
var bool start;

//Debug function
simulated private function DebugPrint(int sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}

/////////////////////////////////////////////////////
//prompts an are you sure message 
exec function  mainmen()
{

	x = true;
	//menu_prompt.Init();
	if (menu_prompt == None)
        {
            menu_prompt = new class'LF_Menu_Prompt';            
		}
	menu_prompt.Init();

}
//goes to main menu if pressed while prompt is displayed
exec function yes()
{

	local bool check;
	check = menu_prompt.open_check();

	if(check == true)
	{
	menu_prompt.End();
	consolecommand("open betamen_1");

		if (main_menu == None)
		{
			main_menu = new class'LF_Main_Menu';
			main_menu.Init();
		}
	}
}
//deletes prompt and continues game
exec function no()
{
	menu_prompt.End();
	x = false;

}
/////////////////////////////////////////////////////

/////////////////////////////////////////////////////
//Rebinds escape to show the pause menu
exec function ShowMenu()
{
	// if using GFx HUD, use GFx pause menu
    PauseMenu.AddFocusIgnoreKey('E');
	TogglePauseMenu();
}

// Displays the pause menu defined in LF_PauseMenu
function int TogglePauseMenu()
{
	if (PauseMenu.bIsOpen == true )
	{
		PauseMenu.AddFocusIgnoreKey('E');
		PlayerOwner.SetPause(False);
		PauseMenu.End();
		PauseMenu.bIsOpen = false;
		x = false;
		return 1;
	}
	else
	{
			PauseMenu = new class'LF_PauseMenu';
            PauseMenu.MovieInfo = SwfMovie'beta_pause_menu.beta_pause';
            PauseMenu.bEnableGammaCorrection = FALSE;
            PauseMenu.LocalPlayerOwnerIndex = class'Engine'.static.GetEngine().GamePlayers.Find(LocalPlayer(PlayerOwner.Player));
            PauseMenu.SetTimingMode(TM_Real); 
			PauseMenu.Start();
			PlayerOwner.SetPause(True);
			PauseMenu.AddFocusIgnoreKey('E');
			return 0;
	}

}
function heart_rate_movie()
{
	if (h_HUD == None)
    {
        h_HUD = new class'LF_Heart_HUD';            
	}
	h_HUD.Init();

}
function mission1_movie()
{
	if (mission1_mov == None)
    {
        mission1_mov = new class'LF_Mission1_Description';            
	}
	if(player_m_1 == false)
	{
		mission1_mov.Init();
		SetTimer(7,false,'close_mission1');
		player_m_1 = true;
	}
	else
	{
		return;
	}
	
}

function close_mission1()
{
	mission1_mov.End();
}

function mission1_obj_movie()
{

	if (mission1_objc_mov == None)
    {
        mission1_objc_mov = new class'LF_Mission1_Objective_Movie';            
	}
	if(player_obj_1 == false)
	{
		mission1_objc_mov.Init();
		player_obj_1 = true;
	}
	else
	{
		return;
	}
	

}
function mission2_movie()
{
	if (mission2_mov == None)
    {
        mission2_mov = new class'LF_Mission2_Description';            
	}
	if(player_m_2 == false)
	{
		mission2_mov.Init();
		SetTimer(7,false,'close_mission2');
		player_m_2 = true;
	}
	else
	{
		return;
	}
	
}

function close_mission2()
{
	mission2_mov.End();
}
/////////////////////////////////////////////////////

//Renders all mission based prompts
// Gives dynamic actors rendering ability... e.g. monsters...
function PostRender()
{	
	local monster DebugPawn;
    local monsteridle Deb;
	local Vector CameraLocation;
	local Rotator CameraRotation;
    local Font previous_font;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
	
	Super.PostRender();
	CheckViewPortAspectRatio();
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    //a.mission1 = true;
	if(start == false)
	{
		heart_rate_movie();
		start = true;
	}

		h_HUD.text.SetText(string((a.health/7)));
	
	//renders text for high heart rate
	if(a.health < 150)
	{
	previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(575,455);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("HIGH HEART RATE!!!!"); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
	}
	
	//Top Right
	// Canvas.SetPos(SizeX - 300,SizeY - 650);
	if(a.mission1 == true && a.mission2a == false)
	{
		//a.mission1 = false;
		mission1_movie();  
	}
	//mission 1 text
    if(a.mission1 == true && a.mission2a == false)
    {
		mission1_obj_movie();
		if(a.foodc == 1 && a.waterbottlec == 0 && a.batteryc == 0)
		{
			mission1_objc_mov.movie.GotoAndStopI(2);
		}
		else if(a.foodc == 0 && a.waterbottlec == 1 && a.batteryc == 0)
		{
			mission1_objc_mov.movie.GotoAndStopI(3);
		}
		else if(a.foodc == 0 && a.waterbottlec == 0 && a.batteryc == 1)
		{
			mission1_objc_mov.movie.GotoAndStopI(4);
		}
		else if(a.foodc == 0 && a.waterbottlec == 1 && a.batteryc == 1)
		{
			mission1_objc_mov.movie.GotoAndStopI(5);
		}
		else if(a.foodc == 1 && a.waterbottlec == 0 && a.batteryc == 1)
		{
			mission1_objc_mov.movie.GotoAndStopI(6);
		}
		else if(a.foodc == 1 && a.waterbottlec == 1 && a.batteryc == 0)
		{
			mission1_objc_mov.movie.GotoAndStopI(7);
		}
    }
	
	//mission 2 a text
    if(a.mission1 == true && a.mission2a == true && a.mission2b == false)
    {
		if(mission1_objc_mov_end_bool == false)
		{
			mission1_objc_mov.End();
			mission1_objc_mov_end_bool = true;
		}
		mission2_movie(); 
    }
	
	//mission 2 b text
    if(a.mission1 == true && a.mission2a == true && a.mission2b == true&&a.mission3==false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.duct); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;;
    Canvas.SetPos(915,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Roll of Duct Tape");
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,75);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.wire); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,75);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Copper Wire");
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,100);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.strip); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,100);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Wire Stripper");
    previous_font = Canvas.Font;
    }
	
	// mission 3 text
    if(a.mission1 == true && a.mission2a == true && a.mission2b == true&&a.mission3 == true&&a.mission3p == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Find a power source"); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
	
	//puzzle prompt
     if(a.mission1 == true && a.mission2a == true && a.mission2b == true&&a.mission3 == true&&a.mission3p == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Get the main switch working"); 
    Canvas.Font = previous_font; 

		previous_font = Canvas.Font;
		Canvas.Font = lf;; 
		Canvas.SetPos(CenterX,CenterY);
		Canvas.SetDrawColor(255,50,15,255);
		//make a crosshair for user
		Canvas.DrawText("+"); 
		Canvas.Font = previous_font; 
		previous_font = Canvas.Font;
    }
	
	// mission 4 text
    if(a.mission4 == true&&a.mission5 == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Defeat all the monsters and escape"); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
	
	//mission 5 text
    if(a.mission4 == true&&a.mission5 == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Get to the top of the island!"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
		//adds rendering ability to monsters
		ForEach DynamicActors(class'monster', DebugPawn)
		{
			AddPostRenderedActor(DebugPawn);
		}
		ForEach DynamicActors(class'monsteridle', Deb)
		{
			AddPostRenderedActor(Deb);
		}
			//draws 
			if (PlayerOwner != None)
			{
				PlayerOwner.GetPlayerViewpoint(CameraLocation, CameraRotation);
				DrawActorOverlays(CameraLocation, CameraRotation);
			}
}

function CheckViewPortAspectRatio()
{
        local vector2D ViewportSize;
		local bool bIsWideScreen;
        local GD2PlayerController PC;

        ForEach AllActors(class'GD2PlayerController', PC)
	{
		LocalPlayer(PC.Player).ViewportClient.GetViewportSize(ViewportSize);
		SizeX = ViewPortSize.X;
		SizeY = ViewPortSize.Y;
		break;
	}
        
        bIsWideScreen = (ViewportSize.Y > 0.f) && (ViewportSize.X/ViewportSize.Y > 1.7);

        if ( bIsWideScreen )
	{
			RatioX = SizeX / 1280.f;
	        RatioY = SizeY / 720.f;
	}
}
defaultproperties
{
x = false;
player_m_1 = false
player_obj_1 = false
lf = Font'EngineFonts.lffont'
mission1_objc_mov_end_bool = false
start = false
}
