class monsteraidle extends AIController;
/*
Controller class for the singleinstance ai after interacting
with the phone table
It is not as sophisticated as the other monsters, it simply
waits for a while in one spot and then chases the player
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
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


//Checks if it can see the player
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

//Plays idle animation
function idle()
{
monsteridle(Pawn).Idle.PlayCustomAnim('Idle',0.3);
}

//Goes to attck state
function attacking()
{
ClearTimer('idle');
GoToState('moving');
}

//Chases and attacks player indefinatly
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