class mission2arrow extends trigger;
var int RotatingSpeed;
var int SpeedFade;
event Tick( float DeltaTime ) 
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
     local Rotator final_rot;
    super.Tick(DeltaTime);
    final_rot = Rotation;
	RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
	final_rot.Yaw = final_rot.Yaw + RotatingSpeed*DeltaTime;
	SetRotation(final_rot);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    if(a.mission1 == true && a.mission2a == true && a.mission2b == false)
    SetHidden(false);// = false;
     else
    SetHidden(true);
}
defaultproperties
{
  Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
    Begin Object Name=CollisionCylinder
       CollisionHeight =40.000000
       CollisionRadius=20.00000
    End Object
    CylinderComponent=CollisionCylinder
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'WayPoint.waypoint_mesh'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
       RotatingSpeed = 25000
    SpeedFade = 1
bHidden = true
}