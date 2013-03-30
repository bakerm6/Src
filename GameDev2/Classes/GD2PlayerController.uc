class GD2PlayerController extends UTPlayerController;
//Function to output debug messages
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
//combat function that exectues when z is pressed
exec function attackb()
{
local monster ai;
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
GD2PlayerPawn(Pawn).blockbb = false;
ForEach AllActors(class'monster',ai)
{
Distance = VSize(Player_location_actor.Location - ai.Location);
if(Distance<0)
    Distance*=-1;
if(Distance>300&&Distance<700)
{
ai.monster_health-=10;
ai.dead();
//DebugPrint("HIT");
}
}
}
//block function that executes when c is pressed
exec function blockb()
{
local monster ai;
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
ForEach AllActors(class'monster',ai)
{
Distance = VSize(Player_location_actor.Location - ai.Location);
if(Distance<0)
    Distance*=-1;
if(Distance<700 && Distance<300)
{
GD2PlayerPawn(Pawn).blockbb = true;
}
else
GD2PlayerPawn(Pawn).blockbb = false;
}
}

defaultproperties
{

   CameraClass=class'GameDev2.GD2PlayerCamera'
   bCollideActors=true
   // bBehindView=false
   // bForceBehindView=false
}