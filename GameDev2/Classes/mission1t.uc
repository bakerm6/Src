Class mission1t extends Trigger;
/*
Invisible trigger to start mission 1 in Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
var soundcue player;
var bool play;
// on a touch of the trigger mission 1 starts
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
	local rotatinumbrella p;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
	ForEach AllActors(class'rotatinumbrella',p) 
	{
	p.Go = true;
	}
    if (Pawn(Other) != none)
    {
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    a.mission1 = true;
    if(play == false)
    {
    PlaySound(player);
    play = true;
    }
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
    player = Soundcue'Sounds.wellifimgoingtobeherethislongc'
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    bBlockActors=false
    bHidden=true
    play = false
    bPostRenderIfNotVisible=true
}