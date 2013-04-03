class monsterai extends AIController;
var int CloseEnough;
var int _PathNode;
var Actor Target;
var float Distance;
var actor destination;
var SoundCue scream;
var bool Sound_Bool;
var float Path_Count;
var GD2PlayerPawn p;
//Puts movement and a soundcue on the monster
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    Sound_Bool = true;
    pathfind();
    SetTimer(4,true,'pathfind');
}
//Prints debug client messages
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
function idle()
{
monster(Pawn).Idle.PlayCustomAnim('Idle',1.0);
}
//Updates each frame
simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);
    if(Pawn !=None)
    {
    //PathFind();
    }
}
//Main function for pathfinding among an aray of pathnodes in order
//The order is set in the monster properties
simulated function PathFind()
{
    local int Distance_p;
   
    Distance_p = VSize(monster(Pawn).Waypoints[_PathNode].Location-Pawn.Location);

	if (Distance_p <= CloseEnough)
		{	
			_PathNode=_PathNode++;						
            
		}
        GoToState('Pathfinding');
        if (_PathNode >= monster(Pawn).Waypoints.Length)
		{
			_PathNode = 0;
		}
}

//State that does the pathfinding
//It is set to chase the player if they get within a certain distance of the monster
state Pathfinding 
{
Begin:
    Target = GetALocalPlayerController().Pawn;
    p  = GD2PlayerPawn(Target);
    Distance = VSize(Target.Location - Pawn.Location);
    if(Distance <0)
        Distance*=-1;
    if (Distance < 900)
    {
        if(Sound_Bool!= false && Path_Count <1)
        {
            PlaySound( scream );
        }
        Sound_Bool = false;
        Path_Count+=1;
        MoveToward(Target, Target, 128);
        if(p.health > 5)
        {
        pathfind();
        }
    }
        
    else if(monster(Pawn).Waypoints[_PathNode] != None)
    {
    Path_Count = 0;
    Sound_Bool = true;
    MoveToward(monster(Pawn).Waypoints[_PathNode], monster(Pawn).Waypoints[_PathNode], 128);
    idle();
    }   
    Sleep(0);
}

DefaultProperties
{
    scream = SoundCue'Sounds.mstwoc'
    CloseEnough = 200
    Path_Count = 0;
}