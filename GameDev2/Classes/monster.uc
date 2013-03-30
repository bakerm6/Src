class monster extends GamePawn
    placeable;
//var() SkeletalMeshComponent SkeletalMesh;
var() AnimNodeSlot FullBodyAnimSlot;
var() array<Pathnode> Waypoints;
var() int monster_health;
var() const string Attack_Message;
var() const string Attack_Message1;
var() const string Attack_Message2;
event PostBeginPlay()
{
 super.PostBeginPlay();
 blocker();
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
 if(Distance<700)
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
    local Font previous_font;
    Message = Attack_Message;
    Message1= Attack_Message1;
    Message2= Attack_Message2;
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    range_check = in_range();
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    //a = GD2PlayerPawn(Player_Location_Actor);
    Distance = VSize(self.Location - Player_Location_Actor.Location);
    //if(a.Health < 0)
    //DebugPrint("Quit");
    if(Distance<0)
    Distance*=-1;
    if(range_check==true && Distance>325)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(Message); 
    Canvas.Font = previous_font;
    }
    if(range_check==true && Distance<300)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(Message1);
    Canvas.Font = previous_font;
    //if(a.blockbb == true)
    //{
    //a.Health -=10;
    //}
    //else
    //{
    //a.health -=100;
    //}
    //FullBodyAnimSlot.PlayCustomAnim('attck',1.f);
    }
    else
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(Message2);
    Canvas.Font = previous_font;
    }
}
function blocker()
{
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    local int Distance;
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    Distance = VSize(self.Location - Player_Location_Actor.Location);
    if(Distance<0)
    Distance*=-1;
    if(Distance <300)
    {
    if(a.blockbb == true)
    {
    a.Health -=1;
    }
    else
    {
    a.health -=3;
    }
    }
}
//Checks each frame
function Tick(float Delta)
{
super.Tick(Delta);
blocker();
}
//Checks for a bump
event Bump(Actor Other, PrimitiveComponent OtherComp, Vector HitNormal)
{
local Pawn pawnLocal;  
   pawnLocal = Pawn( Other ); 
   
   if(pawnLocal != None)
   {
        //test if it is the Player
      if(pawnLocal.bCollideActors && !pawnLocal.controller.bIsPlayer)
      {
        //DebugPrint("touch");
      }
}
}
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
       CollisionHeight =+44.000000
       CollisionRadius=+20.00000
 End Object
 CylinderComponent=CollisionCylinder
 Begin object class=AnimNodeSequence name=monsteranim 
 End object
 Begin Object class=SkeletalMeshComponent Name=MySkeletalMeshComponent
    SkeletalMesh=SkeletalMesh'monster_animation.block_monster_attack'
    AnimtreeTemplate= AnimTree'monster_animation.attack'
    AnimSets(0)=AnimSet'monster_animation.box_anim'
 End Object
  Mesh=MySkeletalMeshComponent
  Components.Add(MySkeletalMeshComponent)
  ControllerClass=class'GameDev2.monsterai'
  RotationRate = (Pitch=6000,Yaw=6000,Roll=6000)
   bCollideActors=true
   bJumpCapable=false
   bCanJump=false
   bNoDelete = false
   bStatic = false
   bPostRenderIfNotVisible=true
   GroundSpeed=200.0
}

