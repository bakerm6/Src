class testPawn extends GamePawn;

DefaultProperties
{
	begin object Class=CylinderComponent Name=CylComponent
		CollisionRadius =+ 20.0
		CollisionHeight =+ 40.0
		end object

	Components.Add(CylComponent)
	CylinderComponent = CylComponent

	begin object Class=DynamicLightEnvironmentComponent Name=UPawnEnvironment
		bSynthesizeSHLight = true
		end object
	
	Components.Add(UPawnEnvironment)
	LightComponent = UPawnEnvironment
}