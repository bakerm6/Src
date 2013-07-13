class GD2PlayerPawn extends UTPawn;
/*
Player class for Landfall
Contains many gloabl counting variables and bools to trigger in game events
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var SpotLightMovable Flashlight;

var Rotator newRot;

var Vector newLoc;

var SoundCue heartb;

var int waterbottlec;
var int foodc;
var int flashlightc;
var int batteryc;
var int duct;
var int wire;
var int strip;
var int killcount;

var bool mission1;
var bool mission2a;
var bool mission2b;
var bool mission3;
var bool mission3p;
var bool mission4;
var bool mission5;
var bool bCanDodge;
var bool blockbb;
var bool done;
var bool twocall;
var bool stopdoingthings;


//disables dodge
function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	if(bCanDodge)
	{
	return super.Dodge(DoubleClickMove);
	}

	return false;
}

//////////////////////////////////////////
//initiates for dialog sequence
function wait()
{
SetTimer(26,false,'reset');
}
//resets player movement ability
function reset()
{
groundspeed = 300;
SetTimer(5,false,'mission3start');
}
//allows for soundcue in controller class to activate
function mission3start()
{
mission3 = true;
}
//////////////////////////////////////////

//sets health and speed for health regeneration
simulated function PostBeginPlay()
{
	//Flashlight = Spawn(class'GameDev2.PlayerFlashlight', self);
	Super.PostBeginPlay();
    Health = 700;
    SetTimer(1,true,'regen');
}
//debug function
simulated private function DebugPrint1(int sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
//Regenerates health
function regen()
{
    if(Health < 700&& Health > 0)
    {
    Health += 12;
    //Health += 700;
    }
}

//////////////////////////////////////////
//checks every frame for certain events such as dying,completing missions, and activiating kismet sequences
event Tick( float DeltaTime ) {
    //DebugPrint1(Health);
    local GD2PlayerController g;
    super.Tick(DeltaTime);
    g= GD2PlayerController(self.controller);
    //DebugPrint1(killcount);
		if(Health <= 0)
		{
		self.Destroy();
		}
		if(done==false && batteryc == 1 && flashlightc == 1)
		{
		TriggerRemoteKismetEvent('flashlight_toggle' );
		done = true;
		}
		if(batteryc == 1 && flashlightc == 1 && foodc == 1 && waterbottlec == 1 && twocall == false)
		{
		//DebugPrint1(1);
		mission2a = true;
		twocall = true;
		}
		if(mission4 == true)
		{
		g.mapc = 2;
		}
		if(killcount > 5)
		{
		mission5 = true;
		}
    
}

//allows for kismet events to be called through unreal script
function TriggerRemoteKismetEvent( name EventName )
{
	local array<SequenceObject> AllSeqEvents;
	local Sequence GameSeq;
	local int i;

	GameSeq = WorldInfo.GetGameSequence();
	if (GameSeq != None)
	{
		// reset the game sequence
		GameSeq.Reset();

		// find any Level Reset events that exist
		GameSeq.FindSeqObjectsByClass(class'SeqEvent_RemoteEvent', true, AllSeqEvents);

		// activate them
		for (i = 0; i < AllSeqEvents.Length; i++)
		{
			if(SeqEvent_RemoteEvent(AllSeqEvents[i]).EventName == EventName)
			{
				SeqEvent_RemoteEvent(AllSeqEvents[i]).CheckActivate(WorldInfo, None);
			}
		}
	}
}
//////////////////////////////////////////

//adds default inventory
//function AddDefaultInventory()
//{
    //InvManager.CreateInventory(class'GameDev2.testweapon'); //InvManager is the pawn's InventoryManager
//}

defaultproperties 
{
	/*Begin Object Class=SpotLightMovable Name=MyFlashlight
	  bEnabled=true
	  Radius=10240.000000
	  Brightness=1000000.90000
	  bForceDynamicLight=true
	End Object
	Components.Add(MyFlashlight)
	Flashlight=MyFlashlight*/
	
    InventoryManagerClass=class'GameDev2.testmanager'
	

    HealthMax = 700;
    Health = 0;
    GroundSpeed = 100
    AirSpeed = 100
    waterbottlec = 0
    foodc = 0
    flashlightc = 0
    batteryc = 0
    duct = 0;
    wire = 0;
    strip = 0;
	killcount = 0
		
    bPostRenderIfNotVisible=true
    mission1= false
    mission2a = false
    mission2b = false
    mission3 = false
    mission3p = false
    mission4 = false
    mission5 = false
    twocall = false
    done = false
	blockbb = false
    bStatic = false
	stopdoingthings = false
	
    SpawnSound=none
    //RespawnSound=none

	// weapon=GD2Flashlight
}
