class testPawn extends GamePawn;
/*
Initial test pawn when using UDK
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

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