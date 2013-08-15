class LF_trigger_interaction_prompt extends GFxMoviePlayer;

/*
GFxMovie that playes for most interactable triggers in games
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
DefaultProperties
{
	bDisplayWithHudOff=false
	MovieInfo=SwfMovie'LF_HUD.trigger_interact'
	bEnableGammaCorrection = true;
	bIsOpen = false;
}

