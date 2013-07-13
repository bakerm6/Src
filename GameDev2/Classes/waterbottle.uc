class waterbottle extends GamePawn
    placeable;
	
 /*
 Testing meshes in UDK
 DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
 */
 
 //initialize variables
var() StaticMeshComponent StaticMesh;


event PostBeginPlay()
{
 super.PostBeginPlay();
}


DefaultProperties
{
 Begin Object Name=CollisionCylinder
       CollisionHeight =+44.000000
       CollisionRadius=+20.00000
 End Object
 CylinderComponent=CollisionCylinder
 Begin Object class=StaticMeshComponent Name=MyStaticMeshComponent
    StaticMesh=StaticMesh'E3_Demo.Meshes.SM_Barrel_01'
 End Object
  StaticMesh=MyStaticMeshComponent
  Components.Add(MyStaticMeshComponent)
  
   bJumpCapable=false
   bCanJump=false
   bNoDelete = false
   
}