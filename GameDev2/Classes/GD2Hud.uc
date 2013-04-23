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
var LF_PauseMenu PauseMenu;
var bool y;
var bool x;
var(Rendertext) Font lf;
//Debug function
simulated private function DebugPrint(int sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
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
    if(x == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(575,450);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Return to Main Menu Y/N"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    if(a.mission1 == true && a.mission2a == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.waterbottlec); //Prompt is a string variable defined in our new actor's class.
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
    Canvas.DrawText(a.foodc); //Prompt is a string variable defined in our new actor's class.
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
    Canvas.DrawText(a.batteryc); //Prompt is a string variable defined in our new actor's class.
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
    Canvas.DrawText(a.flashlightc); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,125);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Flashlight");
    }
    if(a.mission1 == true && a.mission2a == true && a.mission2b == false)
    {
    //DebugPrint("F");
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Find a telephone"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    if(a.mission1 == true && a.mission2a == true && a.mission2b == true&&a.mission3==false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(a.duct); //Prompt is a string variable defined in our new actor's class.
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
    Canvas.DrawText(a.wire); //Prompt is a string variable defined in our new actor's class.
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
    Canvas.DrawText(a.strip); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(915,100);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(" X    Wire Stripper");
    previous_font = Canvas.Font;
    }
    if(a.mission1 == true && a.mission2a == true && a.mission2b == true&&a.mission3 == true&&a.mission3p == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Find a power source"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
     if(a.mission1 == true && a.mission2a == true && a.mission2b == true&&a.mission3 == true&&a.mission3p == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Get the main switch working"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    if(a.mission4 == true&&a.mission5 == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Defeat all the monsters and escape"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    if(a.mission4 == true&&a.mission5 == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;; 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Get to the pier!"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
	ForEach DynamicActors(class'monster', DebugPawn)
	{
		AddPostRenderedActor(DebugPawn);
	}
    ForEach DynamicActors(class'monsteridle', Deb)
	{
		AddPostRenderedActor(Deb);
	}

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