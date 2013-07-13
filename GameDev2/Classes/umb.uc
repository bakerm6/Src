class umb extends AIController;
/*
Controller class for umbrella
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

State moving
{
begin:
		if(rotatinumbrella(Pawn).Go == true)
		{
        rotatinumbrella(Pawn).GroundSpeed = 125.00;
        MoveToward(rotatinumbrella(Pawn).Waypoints[0], rotatinumbrella(Pawn).Waypoints[0], 128);
		}
		sleep(0);
}

DefaultProperties
{
}