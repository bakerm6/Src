class LF_PauseMenu extends GFxMoviePlayer;
/*
Pause menu movie class for landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
//initialize variables
var GFxObject  RootMC;

//Starts the movie
function bool Start(optional bool StartPaused = false)
{
        super.Start();
        Advance(0);
        RootMC = GetVariableObject("_root");
        return true;
} 

defaultproperties
{
    bEnableGammaCorrection=FALSE
	bPauseGameWhileActive=True
	bIgnoreMouseInput = false
	bCaptureInput=False
}
