class LF_PauseMenu extends GFxMoviePlayer;
var GFxObject  RootMC;

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
