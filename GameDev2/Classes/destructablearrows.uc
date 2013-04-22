class destructablearrows extends trigger;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
     Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    if (Pawn(Other) == a)
    {
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        self.Destroy();
        //DebugPrint("here");
    }
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
     bBlockActors=true
    bCollideActors=true
    bHidden=false
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
    }