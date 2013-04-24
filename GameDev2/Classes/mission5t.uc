Class mission5t extends Trigger;
/*
Activates mission 5/endgame and allows for player controller
to end game
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
var soundcue player;
var bool play;
var SoundCue circus;
// on touch mission 4 begins
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
    if(a.mission5 == true)
    {
    c.endgamescene();
    }
    
    
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        //PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        //IsInInteractionRange = true;
    }
}
// plays ambient theme park music

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
    play = false
    bPostRenderIfNotVisible=true
}