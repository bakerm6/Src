class LF_Mission1_Description extends GFxMoviePlayer;

/*
GFxMovie that plays a description of Mission1
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

var bool bIsOpen;

function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	bIsOpen = true;
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
	MovieInfo=SwfMovie'LF_HUD.mission_1_movie'
	bEnableGammaCorrection = true;
	bIsOpen = false;
}