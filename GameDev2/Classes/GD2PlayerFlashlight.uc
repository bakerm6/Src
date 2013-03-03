class GD2PlayerFlashlight extends GD2Flashlight;

DefaultProperties
{
	LightAttachInterval=1.30
	LightOnInterval=0.60
	begin object Name=TorchLightComponent
Begin Object Class=LightFunction Name=MyLightFunction
SourceMaterial=Material'WP_ShockRifle.Effects.M_WP_ShockRifle_SoftLight_Z2'
			Scale=(X=250.000000,Y=250.000000,Z=250.000000)
			end object
		InnerConeAngle=22.000000
		OuterConeAngle=30.000000
		Radius=600.000000
		BrightNess=1.500000
		LightColor=(B=230,G=255,R=255,A=0)
		End Object
	LightAttachment=TorchLightComponent
}
