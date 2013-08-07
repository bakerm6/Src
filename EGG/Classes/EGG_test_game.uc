class EGG_test_game extends FrameWorkGame;

event PostLogin( PlayerController NewPlayer )
{
 super.PostLogin( NewPlayer );
}
simulated function StartMatch()
{
	super.StartMatch(); 
}
static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
return Default.class;
}

defaultproperties
{
   PlayerControllerClass=class'EGG.EGG_test_controller'
   DefaultPawnClass=class'EGG.EGG_test_pawn'
   HUDType=class'EGG.EGG_test_hud'
   bDelayedStart=false
}