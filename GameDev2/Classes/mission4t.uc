Class mission4t extends Trigger;
var soundcue player;
var bool play;
var SoundCue circus;
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    local GD2PlayerController c;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
     c = GD2PlayerController(GetALocalPlayerController());
    a.mission4 = true;
    c.mapc = 2;
    
    if(play == false)
    {
    PlaySound(player);
    circusong();
    play = true;
    }
    
    
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        //PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        //IsInInteractionRange = true;
    }
}
function circusong()
{
PlaySound(circus);
SetTimer(155,true,'circussong');
}
DefaultProperties
{
Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
 
    Begin Object Class=StaticMeshComponent Name=MyMesh
        StaticMesh=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_SHORT'
    End Object
    player = Soundcue'Sounds.ohnothatsnotgoodc'
    circus = SoundCue'Sounds.circusc'
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    bBlockActors=false
    bHidden=true
    play = false
    bPostRenderIfNotVisible=true
}