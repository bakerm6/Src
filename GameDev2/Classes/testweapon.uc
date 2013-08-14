class testweapon extends UDKWeapon;
/*
First person arms for Landfall
Contains animations that are called based on bools in player pawn and player controller
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//Initialize variables
var bool check;
var AnimNodePlayCustomAnim Attack;
//var AnimNodePlayCustomAnim Idle;
var AnimNodePlayCustomAnim Block;


// Sets animation node slots so they can be called in unrealscript
simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super.PostInitAnimTree(SkelComp);

    if (SkelComp == Mesh)
    {          
		//Attack and block animations
        Attack = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('FP_attack_node'));     //('Fp_attack'));
        Block = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('FP_block_node'));     //('Fp_block'));
       
    }
}


//Sets the arms in a position in front of player to look like arms
//checks the player controller attack and block bools to know whether to play an animation
simulated event SetPosition(UDKPawn Holder)
{
    local vector FinalLocation;
    local vector X,Y,Z;
    local GD2PlayerController k;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
	
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    k= GD2PlayerController(a.controller);
	
    //local rotator c;
    Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
    FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    FinalLocation= FinalLocation+Y*5-Z*11+X*25; // Rough position adjustment
    //FinalLocation= FinalLocation- Y * -12 - Z * -32;
    SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);

    if(k.checka == true)
    {
    Attack.playcustomanim('FP_attack',1.0 );
    }
	
    if(k.checkb == true)
    {
    Block.playcustomanim('FP_block',1.0 );
	k.checkb = false;
    }
	
}

DefaultProperties
{

    Begin object class=AnimNodeSequence name=armanim 
    End object
	
    Begin Object class=SkeletalMeshComponent Name=MySkeletalMeshComponent
    SkeletalMesh=SkeletalMesh'FP_arms_pckg.FP_animations_mesh'
    AnimtreeTemplate= AnimTree'FP_arms_pckg.FP_arms_animtree'
    AnimSets(0)=AnimSet'FP_arms_pckg.FP_arms_animset'
    Translation=(Z=0.0)
	scale=0.4
	HiddenGame=FALSE
    HiddenEditor=FALSE
    End Object
    Mesh=MySkeletalMeshComponent
    //bCastShadows = false
    Components.Add(MySkeletalMeshComponent)
    check = false
   //SpawnRotation=(yaw=6000)
}