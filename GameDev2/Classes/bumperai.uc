class bumperai extends aicontroller;
var int CloseEnough;
var int _PathNode;
var Actor Target;
var float Path_Count;


event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    pathfind();
    SetTimer(4,true,'pathfind');
}
simulated function PathFind()
{
					
         
        
        if (_PathNode >= bumpercar(Pawn).Waypoints.Length)
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
	

    if(bumpercar(Pawn).Waypoints[_PathNode] != None&& bumpercar(pawn).b == true)
    {
    Path_Count = 0;
    MoveToward(bumpercar(Pawn).Waypoints[_PathNode], bumpercar(Pawn).Waypoints[_PathNode], 128);
    }  
	else
	{
	Sleep(1);
	}
    Sleep(0);
}
DefaultProperties
{
    CloseEnough = 200
    Path_Count = 0;
    bPreciseDestination = True
}