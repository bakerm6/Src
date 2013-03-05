class monster extends GamePawn
    placeable;
var() StaticMeshComponent StaticMesh;
var() array<Pathnode> Waypoints;
var () int healtht;
var rotator test;
var bool t;
event PostBeginPlay()
{
 super.PostBeginPlay();
 t = false;
}
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
function Tick(float Delta)
{
super.Tick(Delta);
if(t==true)
{
Velocity = Normal(Vector(Rotation))*GroundSpeed;
SetRotation(RInterpTo(Rotation,test,Delta,90000,true));
}
}
event Bump(Actor Other, PrimitiveComponent OtherComp, Vector HitNormal)
{
local Pawn pawnLocal;  
   pawnLocal = Pawn( Other ); 
   
   if(pawnLocal != None)
   {
        //test if it is the Player
      if(pawnLocal.bCollideActors && !pawnLocal.controller.bIsPlayer)
      {
        DebugPrint("touch");
        t = true;
        //self.SetRotation(Rot(0,16384,0);
        //self.SetRotation(RInterpTo(Rotation,test,Delta,90000,true)); 
      }
      //t = false;
    }
}
function dead()
{
    if(self.healtht <= 0)
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
 Begin Object class=StaticMeshComponent Name=MyStaticMeshComponent
    StaticMesh=StaticMesh'Castle_Assets.Meshes.SM_MonkStatue_01'
 End Object
  StaticMesh=MyStaticMeshComponent
  Components.Add(MyStaticMeshComponent)
  ControllerClass=class'GameDev2.monsterai'
  RotationRate = (Pitch=6000,Yaw=6000,Roll=6000)
   bCollideActors=true
   bJumpCapable=false
   bCanJump=false
   bNoDelete = false
   GroundSpeed=200.0
}

