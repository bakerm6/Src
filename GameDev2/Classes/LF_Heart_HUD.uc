class LF_Heart_HUD extends GFxMoviePlayer;

/*
Flash Movie for Player Health
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var bool bIsOpen;
var GFxObject text;

//play movie
function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	bIsOpen = true;
	text = GetVariableObject("_root.h_rate");
}
//end movie
function End(optional LocalPlayer LocPlay)
{
	bIsOpen = false;
	Close();
}

//simple check function
function bool open_check()
{
	return bIsOpen;
}
defaultproperties
{
	bDisplayWithHudOff=false
	MovieInfo=SwfMovie'LF_HUD.heart_rate'
	bEnableGammaCorrection = true;
	bIsOpen = false;
}