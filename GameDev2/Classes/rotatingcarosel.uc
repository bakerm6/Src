class rotatingcarosel extends actor
placeable;
/*
Rotating carosel for map2 of Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
var int RotatingSpeed;
var int SpeedFade;
//Rotates every frame to produce spin
event Tick( float DeltaTime ) 
{
    local Rotator final_rot;
    super.Tick(DeltaTime);
    final_rot = Rotation;
	RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
	final_rot.Yaw = final_rot.Yaw + RotatingSpeed*DeltaTime;
	SetRotation(final_rot);
}
defaultproperties
{
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'LF_Buildings.carousel_uved'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
       RotatingSpeed = 12000
    SpeedFade = 1
    bHidden = false
}