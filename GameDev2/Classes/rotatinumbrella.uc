class rotatinumbrella extends GamePawn
placeable;
/*
Rotating umbrella for windy sequence of Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var int RotatingSpeed;
var int SpeedFade;
var bool Go;
var() array<Pathnode> Waypoints;

//Rotates every frame to produce spin
event Tick( float DeltaTime ) 
{
    local Rotator final_rot;
	
    super.Tick(DeltaTime);
	
    final_rot = Rotation;
	RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
	final_rot.Pitch = final_rot.Pitch + RotatingSpeed*DeltaTime;
	final_rot.Roll = final_rot.Roll + RotatingSpeed*DeltaTime;
	SetRotation(final_rot);
}

defaultproperties
{
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'Umbrella_package.umbrella'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    RotatingSpeed = 12000
    SpeedFade = 1
	
    bHidden = false
	Go = false
	//ControllerClass=class'GameDev2.umb'
}