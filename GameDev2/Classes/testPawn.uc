class testPawn extends GamePawn;
event PostBeginPlay()
{
 super.PostBeginPlay();
}

DefaultProperties
{
	begin object Class=CylinderComponent Name=CylComponent
		CollisionRadius =+ 3.0
		CollisionHeight =+ 40.0
		end object

	Components.Add(CylComponent)
	CylinderComponent = CylComponent

	begin object Class=DynamicLightEnvironmentComponent Name=UPawnEnvironment
		bSynthesizeSHLight = true
		end object
	Components.Add(UPawnEnvironment)
   bJumpCapable=false
   bCanJump=false
   bNoDelete = false
   GroundSpeed=300.0
	//LightComponent = UPawnEnvironment
}