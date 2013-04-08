Class whatwasthatt extends Trigger;
var bool played;
var SoundCue what;
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none&&played == false)
    {
        PlaySound(what);
        //played = true;
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        //PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        //IsInInteractionRange = true;
    }
}
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
    played = true;
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
    what = SoundCue'Sounds.whatwasthatc'
    bBlockActors=false
    bHidden=true
    played = false
    bPostRenderIfNotVisible=true
    }