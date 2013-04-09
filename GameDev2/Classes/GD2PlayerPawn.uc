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
var bool mission1;
var bool done;
function bool Dodge(eDoubleClickDir DoubleClickMove)
{
if(bCanDodge)
return super.Dodge(DoubleClickMove);

return false;
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
    TriggerRemoteKismetEvent('flashlght_toggle' );
    //DebugPrint1(1);
    done = true;
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
    bPostRenderIfNotVisible=true
    mission1=true
    done = false;
    spawnsound=none
	// weapon=GD2Flashlight