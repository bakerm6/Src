class monster extends GamePawn
    placeable;
//var() SkeletalMeshComponent SkeletalMesh;
var() AnimNodeSlot FullBodyAnimSlot;
var AnimNodePlayCustomAnim Attack;
var AnimNodePlayCustomAnim Idle;
var() array<Pathnode> Waypoints;
var() int monster_health;
var() const string Attack_Message;
var() const string Attack_Message1;
var() const string Attack_Message2;
var(Rendertext) Font lf;
event PostBeginPlay()
{
 super.PostBeginPlay();
 blocker();
 SetTimer(0.1,true,'attackanim');
}
function attackanim()
{
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
Distance = VSize(Player_location_actor.Location - self.Location);
if(Distance<0)
    Distance*=-1;
 if(Distance<225)
{
self.GroundSpeed = 215.0;
Attack.PlayCustomAnim('melee_attack',1.0);
}
else
self.GroundSpeed = 175.0;
}
simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super.PostInitAnimTree(SkelComp);

    if (SkelComp == Mesh)
    {
        Attack = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('CustomAnim'));
        Idle = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('CustomAnim2'));
    }
}
//Debug Function
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
//Checks if monster is in range to render text
function bool in_range()
{
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
Distance = VSize(Player_location_actor.Location - self.Location);
if(Distance<0)
    Distance*=-1;
 if(Distance<300)
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
    //local GD2PlayerPawn a;
    local int Distance;
    local bool range_check;
    local string Message;
    local string Message1;
    local string Message2;
    local float dot1;
    local vector v;
    local monsterai c;
    local GD2PlayerPawn p;
    local Font previous_font;
    Message = Attack_Message;
    Message1= Attack_Message1;
    Message2= Attack_Message2;
    c = monsterai(self.controller);
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    range_check = in_range();
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
    Idle.PlayCustomAnim('Idle',1.0);
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(Message2);
    Canvas.Font = previous_font;
    }
    if(range_check==true && Distance>200&&dot1 > 0&& c.seebool == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(Message); 
    Canvas.Font = previous_font;
    }
    if(range_check==true && Distance<175&& dot1 >0&&c.seebool == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(Message1);
    Canvas.Font = previous_font;
    }
    else if (range_check == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(Message2);
    Canvas.Font = previous_font;
    c.seebool = false;
    }
}
function blocker()
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    local int Distance;
    local monsterai c;
    c = monsterai(self.controller);
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
//Checks each frame
function Tick(float Delta)
{
super.Tick(Delta);
blocker();
}
/*simulated event RigidBodyCollision( PrimitiveComponent HitComponent, PrimitiveComponent OtherComponent,
const out CollisionImpactData Collision, int ContactIndex )
{
//DebugPrint("FUCK");
}*/
event HitWall (Object.Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
local Vector Location1;
//DebugPrint("Wall");
//Location1 = ((self.Location) - (0,0,90));
//self.Controller.SetDestinationPosition(self.Location);
//StopLatentExecution();
Location1 = vect(0,0,0);
self.acceleration = Location1;
self.controller.GoToState('backup');
//self.controller.movetoward(Waypoints[0],Waypoints[0],128);
}
//Checks for a bump
event Bump(Actor Other, PrimitiveComponent OtherComp, Vector HitNormal)
{
//super.Bump(Other,OtherComp,HitNormal);
//local Pawn pawnLocal;  
//pawnLocal = Pawn( Other ); 
   
  // if(pawnLocal != None)
   //{
        //DebugPrint("Bumpity");
        //test if it is the Player
     // if(pawnLocal.bCollideActors && !pawnLocal.controller.bIsPlayer)
      //{
        //DebugPrint("BUMP");
      //}
}
//}
// Checks if health is depleted and destroys the monster
function dead()
{
    if(self.monster_health <= 0)
    {
        DebugPrint("DEAD");
        self.Destroy();
    }
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
 End Object
  Mesh=MySkeletalMeshComponent
  Components.Add(MySkeletalMeshComponent)
  RotationRate=(Pitch=20000,Yaw=20000,Roll=20000)
  ControllerClass=class'GameDev2.monsterai'
   bCollideActors=true
   bBlockActors=true
   bJumpCapable=false
   bCollideWorld=true
   bCanJump=false
   bNoDelete = false
   bStatic = false
   bPostRenderIfNotVisible=true
   GroundSpeed=300.0
   lf = Font'Sounds.lffont'
}

