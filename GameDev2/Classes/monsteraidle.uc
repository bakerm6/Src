class monsteraidle extends AIController;
var int CloseEnough;
var int _PathNode;
var actor Target;
var float Distance;
var actor destination;
var SoundCue scream;
var bool Sound_Bool;
var bool spawny;
var bool seebool;
var float Path_Count;
var GD2PlayerPawn p;
//Puts movement and a soundcue on the monster
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    Sound_Bool = true;
    SetTimer(0.35,true,'idle');
    SetTimer(13,false,'attacking');
}
event SeePlayer(pawn seen)
{
Super.SeePlayer(seen);
seebool = true;
}
//Prints debug client messages
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
function idle()
{
monsteridle(Pawn).Idle.PlayCustomAnim('Idle',0.3);
}
function attacking()
{
ClearTimer('idle');
GoToState('moving');

}
State moving
{
begin:
 Target = GetALocalPlayerController().Pawn;
        if(Sound_Bool!= false && Path_Count <1)
        {
            PlaySound( scream );
        }
        Sound_Bool = false;
        monsteridle(Pawn).GroundSpeed = 125.00;
        MoveToward(Target, Target, 128);
        attacking();
        ClearTimer('idle');
        sleep(0);
}
DefaultProperties
{
    scream = SoundCue'Sounds.mstwoc'
    CloseEnough = 200
    Path_Count = 0;
    spawny = true
    bPreciseDestination = True
    seebool = false
}