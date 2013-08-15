class bai extends AIController;
/*
bumper car ai debug class for Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/  

//Debug messaging
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}


//debug posses event
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
	here();
}
//debuging
function here()
{
	DebugPrint("here");
}

DefaultProperties
{

}
