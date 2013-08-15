class bumperai extends aicontroller;
/*
bumper car ai class for Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/  
//initialize variables
var int CloseEnough;
var int _PathNode;
var Actor Target;
var float Path_Count;
////////////////////////////////////////////////////////////////
//possesion event to give ai properties
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    pathfind();
    SetTimer(4,true,'pathfind');
}
//checks what pathnode in the list to set before pathfinding
simulated function PathFind()
{
					
         
        
        if (_PathNode >= LF_bumper_car(Pawn).Waypoints.Length)
		{
			_PathNode = 0;
		}
        else
           _PathNode=_PathNode++;
        GoToState('Pathfinding');
}

//State that does the pathfinding
//It is set to chase the player if they get within a certain distance of the monster
state Pathfinding 
{
Begin:
	

    if(LF_bumper_car(Pawn).Waypoints[_PathNode] != None&& LF_bumper_car(pawn).b == true)
    {
    Path_Count = 0;
    MoveToward(LF_bumper_car(Pawn).Waypoints[_PathNode], LF_bumper_car(Pawn).Waypoints[_PathNode], 128);
    }  
	else
	{
	Sleep(1);
	}
    Sleep(0);
}
////////////////////////////////////////////////////////////////

DefaultProperties
{
    CloseEnough = 200
    Path_Count = 0;
    bPreciseDestination = True
}