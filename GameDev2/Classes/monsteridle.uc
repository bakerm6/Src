class monsteridle extends GamePawn
    placeable;
/*
Single instance idle monster in Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
//var() SkeletalMeshComponent SkeletalMesh;
var() AnimNodeSlot FullBodyAnimSlot;
var AnimNodePlayCustomAnim Attack;
var AnimNodePlayCustomAnim Idle;
//var() array<Pathnode> Waypoints;
var int monster_health;
var(Rendertext) Font lf;
//var const string Attack_Message;
//var const string Attack_Message1;
//var const string Attack_Message2;
//Gives it syncing for attack animation
event PostBeginPlay()
{
 super.PostBeginPlay();
 blocker();
 SetTimer(0.1,true,'attackanim');
}
//Sets animation nodes for unreal script usage
simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super.PostInitAnimTree(SkelComp);

    if (SkelComp == Mesh)
    {
        Attack = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('CustomAnim'));
        Idle = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('CustomAnim2'));
    }
}
//Plays attack animation when within a certain distance of the player
function attackanim()
{
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
Distance = VSize(Player_location_actor.Location - self.Location);
if(Distance<0)
    Distance*=-1;
 if(Distance<325)
{
self.GroundSpeed = 215.0;
Attack.PlayCustomAnim('melee_attack',1.0);
}
else if(Distance < 900)
{
self.GroundSpeed = 175.0;
}
}
//Debug Function
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
//Checks if the monster is in range to attack
function bool in_range()
{
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
Distance = VSize(Player_location_actor.Location - self.Location);
if(Distance<0)
    Distance*=-1;
 if(Distance<400)
 {
    return true;
 }
 else 
 return false;
}

//Renders text based on prompts that are inputed in the monster properties
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local actor Player_Location_Actor;
     local monsteraidle c;
    //local GD2PlayerPawn a;
    local int Distance;
    local bool range_check;
    local float dot1;
    local vector v;
    local GD2PlayerPawn p;
    local Font previous_font;
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    range_check = in_range();
    c = monsteraidle(self.controller);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    p  = GD2PlayerPawn(Player_Location_Actor);
    v = Vector(p.Rotation);
    //a = GD2PlayerPawn(Player_Location_Actor);
    Distance = VSize(self.Location - Player_Location_Actor.Location);
    dot1 =v dot (self.Location - Player_Location_Actor.Location);
    //if(a.Health < 0)
    //DebugPrint("Quit");
    if(Distance<0)
    Distance*=-1;
    if(p.health <=0)
    {
    self.Destroy();
    Idle.PlayCustomAnim('Idle',1.0);
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(200,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("");
    Canvas.Font = previous_font;
    }
    if(range_check==true && Distance>200&&dot1 > 0&&c.seebool==true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(200,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press Z to Attack"); 
    Canvas.Font = previous_font;
    //c.seebool=false;
    }
    if(range_check==true && Distance<175&& dot1 >0&&c.seebool==true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(200,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press C to Block");
    Canvas.Font = previous_font;
    //c.seebool=false;
    }
    else if (range_check == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(200,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("");
    Canvas.Font = previous_font;
    c.seebool = false;
    }
}
//checks if player is blocking and does damage accordingly
function blocker()
{
 local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    local int Distance;
    local monsteraidle c;
    c = monsteraidle(self.controller);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    Distance = VSize(self.Location - Player_Location_Actor.Location);
    if(Distance<0)
    Distance*=-1;
    if(Distance <220)
    {
    if(a.blockbb == true && c.seebool == true)
    {
    a.Health -=1;
    }
    else if(a.blockbb == false && c.seebool == true)
    {
    a.health -=5;
    }
    }
}
//Dying function
simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
	GotoState('Dying');
	bReplicateMovement = false;
	bTearOff = true;
	Velocity += TearOffMomentum;
	SetDyingPhysics();
	bPlayedDeath = true;

	KismetDeathDelayTime = default.KismetDeathDelayTime + WorldInfo.TimeSeconds;
}
//sets up ragdolling for death animation
function dead()
{
local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    if(self.monster_health <= 0)
    {
        //DebugPrint("DEAD");
        //self.Destroy();
        Mesh.MinDistFactorForKinematicUpdate = 0.0;

		Mesh.SetRBCollidesWithChannel(RBCC_Default,TRUE);
		Mesh.ForceSkelUpdate();
		Mesh.SetTickGroup(TG_PostAsyncWork);
		CollisionComponent = Mesh;

		// Turn collision on for skelmeshcomp and off for cylinder
		CylinderComponent.SetActorCollision(false, false);
		Mesh.SetActorCollision(true, true);
		Mesh.SetTraceBlocking(true, true);
		SetPhysics(PHYS_RigidBody);
		Mesh.PhysicsWeight = 1.0;

		// If we had stopped updating kinematic bodies on this character due to distance from camera, force an update of bones now.
		if( Mesh.bNotUpdatingKinematicDueToDistance )
		{
			Mesh.UpdateRBBonesFromSpaceBases(TRUE, TRUE);
		}

		Mesh.PhysicsAssetInstance.SetAllBodiesFixed(FALSE);
		Mesh.bUpdateKinematicBonesFromAnimation=FALSE;
		Mesh.SetRBLinearVelocity(Velocity, false);
		Mesh.SetTranslation(vect(0,0,1) * 7);//BaseTranslationOffset);
		Mesh.WakeRigidBody();
        Idle.PlayCustomAnim('Idle',1.0);
        SetTimer(2,false,'kill');
        a.killcount += 1;
    }
}
//destroys actor
function kill()
{
   self.Destroy();
}
//checks for block every frame
function Tick(float Delta)
{
super.Tick(Delta);
blocker();
}
DefaultProperties
{
 Begin Object Name=CollisionCylinder
       CollisionHeight =40.000000
       CollisionRadius=20.00000
 End Object
 CylinderComponent=CollisionCylinder
 Begin object class=AnimNodeSequence name=monsteranim 
 End object
 Begin Object class=SkeletalMeshComponent Name=MySkeletalMeshComponent
    SkeletalMesh=SkeletalMesh'test_anim.monster_test'
   AnimtreeTemplate= AnimTree'test_anim.walk_tree_test'
   AnimSets(0)=AnimSet'test_anim.walk_test'
    Translation=(Z=0.0)
	scale=5.94032
 End Object
  Mesh=MySkeletalMeshComponent
  Components.Add(MySkeletalMeshComponent)
  RotationRate=(Pitch=20000,Yaw=20000,Roll=20000)
  ControllerClass=class'GameDev2.monsteraidle'
   bCollideActors=true
   bBlockActors=true
   bJumpCapable=false
   bCollideWorld=true
   bCanJump=false
   bNoDelete = false
   bStatic = false
   bPostRenderIfNotVisible=true
   GroundSpeed=0.0
   monster_health = 30
   lf = Font'EngineFonts.lffont'
}