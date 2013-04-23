Class mission3t extends Trigger;
/*
trigger that allows for mission 3 puzzle to 
activate in Landfall
The puzzle is a kismetsequence that checks for
the puzzlekmat weapon to be in the player inventory
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
var soundcue player;
var bool play;
// When touched it checks if mission 3 has started and gives the player the weapon if it has
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    local puzzlekmat k;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
    
    if (Pawn(Other) != none)
    {
    k = Spawn(class'puzzlekmat');
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    if(a.mission3 == true)
    {
    if(play == false)
    {
    a.InvManager.AddInventory(k);
    PlaySound(player);
    a.mission3p = true;
    play = true;
    }
    }
    
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
    player = Soundcue'Sounds.hmmthiswillprblyhelpc'
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    bBlockActors=false
    bHidden=true
    play = false
    bPostRenderIfNotVisible=true
}