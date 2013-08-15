class LF_Heart_HUD extends GFxMoviePlayer;

var bool bIsOpen;
var GFxObject text;
function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	bIsOpen = true;
	text = GetVariableObject("_root.h_rate");
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
	MovieInfo=SwfMovie'LF_HUD.heart_rate'
	bEnableGammaCorrection = true;
	bIsOpen = false;
}