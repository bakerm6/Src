class LF_Mission1_Objective_Movie extends GFxMoviePlayer;

/*
GFxMovie that draws an objecvtive box to the HUD
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

var bool bIsOpen;
var GFxObject movie;


function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	bIsOpen = true;
	movie = GetVariableObject("_root");
}

function End(optional LocalPlayer LocPlay)
{
	bIsOpen = false;
	Close();
}
function bool open_check()
{
	return bIsOpen;
}
defaultproperties
{
	bDisplayWithHudOff=false
	MovieInfo=SwfMovie'LF_HUD.mission_1_objective'
	bEnableGammaCorrection = true;
	bIsOpen = false;
}