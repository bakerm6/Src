class bai extends AIController;
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
	here();
}
function here()
{
DebugPrint("here");
}
DefaultProperties
{

}
