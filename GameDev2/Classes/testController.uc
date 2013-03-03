class testController extends PlayerController;
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
/*exec function attackb()
{
local actor t;
local int y;
t = GetALocalPlayerController();
y = VSize(t.Location - Pawn.Location);
if(y<0)
    y*=-1;
if(y<150)
{
TestBot(Pawn).healtht=-10;
DebugPrint("AAA");
}
}*/
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}    
DefaultProperties
{

} 