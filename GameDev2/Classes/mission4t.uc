Class mission4t extends Trigger;


/*
Activates mission 4 and allows for player controller
to know to respawn player on new map
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//Initialize variables
var soundcue player;
var bool play;
var SoundCue circus;
var SoundCue carosel;
var int count;


// on touch mission 4 begins
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    local GD2PlayerController c;
    local testweapon k;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
  
    if (Pawn(Other) != none)
    {
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    c = GD2PlayerController(GetALocalPlayerController());
    a.mission4 = true;
    c.mapc = 2;   
    k = Spawn(class'testweapon');  
    a.InvManager.AddInventory(k);
	
		if(play == false)
		{
		PlaySound(player);
		circusong();
		play = true;
		c.flashb = true;
		a.flashlightc = 1;
		a.batteryc = 1;
		a.InvManager.AddInventory(k);
		}
	}
}
// plays ambient theme park music
function circusong()
{
PlaySound(carosel);
//SetTimer(155,false,'caroselsong');
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
	
    player = Soundcue'Sounds.ohnothatsnotgoodc'
    circus = SoundCue'Sounds.circusc'
    carosel = SoundCue'Sounds.caroselc'

    bBlockActors=false
    bHidden=true
    play = false
    bPostRenderIfNotVisible=true
		
    count = 0;

}
