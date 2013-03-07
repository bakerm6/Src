class monsterai extends AIController;
var int CloseEnough;
var int _PathNode;
var Actor Target;
var float x;
var actor destination;
var SoundCue scream;
var bool temp;
var float count;
var bool attk;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    temp = true;
}

simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}

simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);
    if(Pawn !=None)
    {
    PathFind();
    }
}
simulated function PathFind()
{
    local int Distance;
    Distance = VSize(monster(Pawn).Waypoints[_PathNode].Location-Pawn.Location);

	if (Distance <= CloseEnough)
		{	
			_PathNode=_PathNode++;						
            
		}
        GoToState('Pathfinding');
        if (_PathNode >= monster(Pawn).Waypoints.Length)
		{
			_PathNode = 0;
		}
}
state Pathfinding 
{
Begin: 
    Target = GetALocalPlayerController().Pawn;
    x = VSize(Target.Location - Pawn.Location);
    if(x <0)
        x*=-1;
    if (x < 900)
    {
        if(temp!= false && count <1)
            PlaySound( scream );
        temp = false;
        count+=1;
        MoveToward(Target, Target, 128);
    }
        
    else if(monster(Pawn).Waypoints[_PathNode] != None)
    {
    count = 0;
    temp = true;
    MoveToward(monster(Pawn).Waypoints[_PathNode], monster(Pawn).Waypoints[_PathNode], 128);
    }   
    Sleep(0);
}

DefaultProperties
{
    scream = SoundCue'Sounds.mstwoc'
    CloseEnough = 200
    count = 0;
}