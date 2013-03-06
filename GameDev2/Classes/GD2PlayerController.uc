class GD2PlayerController extends UTPlayerController;

simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
//combat function that exectues when z is pressed
exec function attackb()
{
local monster u;
local actor t;
local int y;
DebugPrint("working");
t = GetALocalPlayerController().Pawn;
ForEach AllActors(class'monster',u)
{
y = VSize(t.Location - u.Location);
GetALocalPlayerController().ClientMessage(y);
if(y<0)
    y*=-1;
if(y<160)
{
u.healtht-=10;
u.dead();
DebugPrint("AAA");
}
}
}


defaultproperties
{
   CameraClass=class'GameDev2.GD2PlayerCamera'
   bCollideActors=true
   // bBehindView=false
   // bForceBehindView=false
}