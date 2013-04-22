class rotatingcarosel extends actor
placeable;
var int RotatingSpeed;
var int SpeedFade;
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