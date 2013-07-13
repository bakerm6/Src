class GD2Hud extends MobileHUD;
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
var bool y;
var bool x;
var(Rendertext) Font lf;


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
}
//goes to main menu if pressed while prompt is displayed
exec function yes()
{

 local GD2PlayerController c;
 
 c = GD2PlayerController(GetALocalPlayerController());
	if(x==true)
	{
	c.quit();
	}
}
//deletes prompt and continues game
exec function no()
{
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
function TogglePauseMenu()
{
    if ( PauseMenu != none && PauseMenu.bMovieIsOpen )
	{
    PauseMenu.AddFocusIgnoreKey('E');
    PlayerOwner.SetPause(False);
    PauseMenu.Close(False);   
    x = false;
	}
    else
    {

        if (PauseMenu == None)
        {
            PauseMenu = new class'LF_PauseMenu';
            PauseMenu.MovieInfo = SwfMovie'pausemen.pausemen';
            PauseMenu.bEnableGammaCorrection = FALSE;
            PauseMenu.LocalPlayerOwnerIndex = class'Engine'.static.GetEngine().GamePlayers.Find(LocalPlayer(PlayerOwner.Player));
            PauseMenu.SetTimingMode(TM_Real);
            PlayerOwner.SetPause(True);
            PauseMenu.AddFocusIgnoreKey('E');
        }

        //SetVisible(false);
        PauseMenu.Start();
        PauseMenu.AddFocusIgnoreKey('E');
        PlayerOwner.SetPause(True);
    }
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
	
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    //a.mission1 = true;
	
	//renders text for high heart rate
	if(a.health < 150)
	{
	previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(575,450);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("HIGH HEART RATE!!!!"); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
	}
	
	//prompts user to return to main menu
    if(x == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(575,450);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Return to Main Menu Y/N"); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
	
	//mission 1 text
    if(a.mission1 == true && a.mission2a == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.waterbottlec); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Watterbottles");
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,75);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.foodc); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,75);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Food");
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,100);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.batteryc); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,100);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Batteries");
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,125);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.flashlightc); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,125);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Flashlight");
    }
	
	//mission 2 a text
    if(a.mission1 == true && a.mission2a == true && a.mission2b == false)
    {
    //DebugPrint("F");
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Find a telephone"); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
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
    Canvas.SetPos(0,0);
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

defaultproperties
{

y = false;
x = false;

lf = Font'EngineFonts.lffont'

}
