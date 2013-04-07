Class mission1t extends Trigger;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    a.mission1 = true;
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        //PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        //IsInInteractionRange = true;
    }
}
DefaultProperties
{
Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
 
    Begin Object Class=StaticMeshComponent Name=MyMesh
        StaticMesh=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_SHORT'
    End Object
 
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    bBlockActors=false
    bHidden=true
    bPostRenderIfNotVisible=true
    }