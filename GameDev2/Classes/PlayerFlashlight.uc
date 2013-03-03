class PlayerFlashlight extends SpotLightMovable
	notplaceable;

//function ToggleLight() {
//	if(!LightComponent.bEnabled){
//		LightComponent.SetEnabled(true); } 
//	else {
//		LightComponent.SetEnabled(false); } }

DefaultProperties {
	Begin Object Class=SpotLightComponent
		Name = SpotLightComponent0
		Radius = 1024.00000
		Brightness = 100.0000
		LightColor = (R=255,B=0,G=0)
		bForceDynamicLight=true
	End Object
};