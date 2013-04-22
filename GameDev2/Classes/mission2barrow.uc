class mission2barrow extends trigger;

event Tick( float DeltaTime ) 
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    super.Tick(DeltaTime);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    if(a.mission1 == true && a.mission2a == true && a.mission2b == true)
    SetHidden(false);// = false;
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
bHidden = true
}