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
local bool a;
DebugPrint("wprk");
a = isclosea();
t = GetALocalPlayerController().Pawn;
ForEach AllActors(class'monster',u)
{
y = VSize(t.Location - u.Location);
GetALocalPlayerController().ClientMessage(y);
if(y<0)
    y*=-1;
if(a==true && y>300)
{
u.healtht-=10;
u.dead();
DebugPrint("HIT");
}
}
}
function bool isclosea()
{
local monster u;
local actor t;
local int y;
t = GetALocalPlayerController().Pawn;
ForEach AllActors(class'monster',u)
{
y = VSize(t.Location - u.Location);
if(y<0)
    y*=-1;
 if(y<700)
 {
    return true;
 }
 else 
 return false;
}
}
function bool iscloseb()
{
local monster u;
local actor t;
local int y;
t = GetALocalPlayerController().Pawn;
ForEach AllActors(class'monster',u)
{
y = VSize(t.Location - u.Location);
if(y<0)
    y*=-1;
 if(y<700)
 {
    return true;
 }
 else 
 return false;
}
}
exec function blockb()
{
local monster u;
local actor t;
local int y;
local bool a;
a = iscloseb();
t = GetALocalPlayerController().Pawn;
ForEach AllActors(class'monster',u)
{
y = VSize(t.Location - u.Location);
if(y<0)
    y*=-1;
if(a==true && y<300)
{
u.healtht-=10;
u.dead();
DebugPrint("Block");
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