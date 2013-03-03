class monsterai extends AIController;
var int CloseEnough;
var int _PathNode;
var Actor Target;
var float x;
var actor destination;
var SoundCue scream;
var bool temp;
var float count;
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    temp = true;
}
exec function attackb()
{
local actor t;
local int y;
t = GetALocalPlayerController().Pawn;
y = VSize(t.Location - Pawn.Location);
if(y<0)
    y*=-1;
if(y<150)
{
monster(Pawn).healtht=-10;
DebugPrint("AAA");
}
}
simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);
    if(Pawn !=None)
    {
    PathFind();
    }
}
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
simulated function PathFind()
{
    local int Distance;
    Distance = VSize(monster(Pawn).Waypoints[_PathNode].Location-Pawn.Location);

	if (Distance <= CloseEnough)
		{	
			_PathNode=_PathNode++;						// Head towards a random PathNode in our array
            
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
    if((x<150))
    {
       //monster(Pawn).healtht =-10;
    }
    if (x < 500)
    {
        if(temp!= false && count <1)
            PlaySound( scream );
        temp = false;
        count+=1;
        MoveToward(Target, Target, 128);
        
    }
        if(monster(Pawn).healtht <= 0)
    {
        DebugPrint("DEAD");
        monster(Pawn).Destroy();
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