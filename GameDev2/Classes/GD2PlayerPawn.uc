class GD2PlayerPawn extends UTPawn;

var SpotLightMovable Flashlight;
var Rotator newRot;
var Vector newLoc;

simulated function PostBeginPlay() {
	//Flashlight = Spawn(class'GameDev2.PlayerFlashlight', self);
	Super.PostBeginPlay();
}

event Tick( float DeltaTime ) {
	newLoc.z = 40;
	Flashlight.SetLocation(self.Location);
	Flashlight.SetLocation(newLoc);
	Flashlight.SetBase(self);
	Flashlight.LightComponent.SetEnabled(true);
	//Flashlight.LightComponent.SetLightProperties(1000);
	newRot.Pitch = 0;
	Flashlight.SetRotation(newRot);

	Flashlight.SetRotation(self.Rotation);
	Flashlight.SetRelativeRotation(newRot);
}

defaultproperties {
	Begin Object Class=SpotLightMovable Name=MyFlashlight
	  bEnabled=true
	  Radius=10240.000000
	  Brightness=1000000.90000
	  bForceDynamicLight=true
	End Object
	Components.Add(MyFlashlight)
	Flashlight=MyFlashlight
	
	// weapon=GD2Flashlight
