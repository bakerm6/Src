class bumpercar extends GamePawn
    placeable;
/*
bumper car class for Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/  

//initialize variables
var() array<Pathnode> Waypoints;
var bool b;


DefaultProperties
{
 Begin Object Name=CollisionCylinder
       CollisionHeight =0.000000
       CollisionRadius=20.00000
 End Object
 CylinderComponent=CollisionCylinder
 Begin Object class=StaticMeshComponent Name=MyMeshy
    StaticMesh=StaticMesh'bumper_car_pkg.bumper_car'
    Rotation=(yaw=4000)
 End Object
  CollisionComponent=MyMeshy
  Components.Add(MyMeshy)
  //RotationRate=(Pitch=20000,Yaw=20000,Roll=20000)
   ControllerClass=class'GameDev2.bumperai'
   bCollideActors=true
   bBlockActors=true
   bJumpCapable=true
   bCollideWorld=true
   bCanJump=true
   bNoDelete = false
   bStatic = false
   bPostRenderIfNotVisible=true
   GroundSpeed=300.0
   b = true
}