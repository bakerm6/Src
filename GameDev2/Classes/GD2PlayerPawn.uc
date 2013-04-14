class GD2PlayerPawn extends UTPawn;
var SpotLightMovable Flashlight;
var Rotator newRot;
var Vector newLoc;
var bool blockbb;
var SoundCue heartb;
var bool bCanDodge;
var int waterbottlec;
var int foodc;
var int flashlightc;
var int batteryc;
var int duct;
var int wire;
var int strip;
var bool mission1;
var bool mission2a;
var bool mission2b;
var bool mission3;
var bool done;
var bool twocall;
function bool Dodge(eDoubleClickDir DoubleClickMove)
{
if(bCanDodge)
return super.Dodge(DoubleClickMove);

return false;
}
function wait()
{
SetTimer(26,false,'reset');
}
function reset()
{
groundspeed = 300;
SetTimer(5,false,'mission3start');
}
function mission3start()
{
mission3 = true;
}
simulated function PostBeginPlay()
{
	//Flashlight = Spawn(class'GameDev2.PlayerFlashlight', self);
	Super.PostBeginPlay();
    Health = 700;
    SetTimer(1,true,'regen');
}
simulated private function DebugPrint1(int sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
function regen()
{
    if(Health < 700&& Health > 0)
    {
    Health += 12;
    }
}

event Tick( float DeltaTime ) {
    //DebugPrint1(Health);
    super.Tick(DeltaTime);
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
    
}
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
				SeqEvent_RemoteEvent(AllSeqEvents[i]).CheckActivate(WorldInfo, None);
		}
	}
}

defaultproperties 
	Begin Object Class=SpotLightMovable Name=MyFlashlight
	  bEnabled=true
	  Radius=10240.000000
	  Brightness=1000000.90000
	  bForceDynamicLight=true
	End Object
	Components.Add(MyFlashlight)
	Flashlight=MyFlashlight
	blockbb = false
    bStatic = false
    HealthMax = 700;
    Health = 700;
    GroundSpeed = 100
    AirSpeed = 100
    waterbottlec = 0
    foodc = 0
    flashlightc = 0
    batteryc = 0
    duct = 0;
    wire = 0;
    strip = 0;
    bPostRenderIfNotVisible=true
    mission1= true
    mission2a = false
    mission2b = false
    mission3 = false;
    twocall = false
    done = false
    SpawnSound=none
    RespawnSound=none
	// weapon=GD2Flashlight