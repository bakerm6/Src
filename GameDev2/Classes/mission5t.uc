Class mission5t extends Trigger;

/*
Activates mission 5/endgame and allows for player controller
to end game
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (LF_Controller)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var soundcue player;
var bool play;
var SoundCue circus;


// on touch mission 4 begins
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn LF_Pawn;
    local GD2PlayerController LF_Controller;
	
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
		Player_Location_Actor = GetALocalPlayerController().Pawn;
		LF_Pawn = GD2PlayerPawn(Player_Location_Actor);
		LF_Controller = GD2PlayerController(GetALocalPlayerController());
	 
		if(LF_Pawn.mission5 == true)
		{
			LF_Controller.endgamescene();
		}
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