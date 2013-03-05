class testController extends PlayerController;
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}


event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}    
DefaultProperties
{

} 