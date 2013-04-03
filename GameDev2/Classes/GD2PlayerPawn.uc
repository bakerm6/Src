class GD2PlayerPawn extends UTPawn;
var SpotLightMovable Flashlight;
var Rotator newRot;
var Vector newLoc;
var bool blockbb;
var SoundCue heartb;
var bool bCanDodge;

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
    if(Health <= 0)
    {
    self.Destroy();
    }
	newLoc.z = 40;
	//Flashlight.SetLocation(self.Location);
	//Flashlight.SetLocation(newLoc);
	Flashlight.SetRelativeLocation(newLoc);
	Flashlight.SetBase(self);
	Flashlight.LightComponent.SetEnabled(true);
	//Flashlight.LightComponent.SetLightProperties(1000);
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
	// weapon=GD2Flashlight