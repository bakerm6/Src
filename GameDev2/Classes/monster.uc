class monster extends GamePawn
    placeable;
var() StaticMeshComponent StaticMesh;
var() array<Pathnode> Waypoints;
var () int healtht;
var int i;
var rotator test;
var bool t;
var() const string Prompt;
var() const string Prompt1;
var() const string Prompt2;
event PostBeginPlay()
{
 super.PostBeginPlay();
 t = false;
}
/*
exec function findthenode()
{
local PathNode p;
local monster u;
local int y;
local int l;
l = 0;
DebugPrint("workingmore");
ForEach AllActors(class'monster',u) 
{
ForEach AllActors(class'PathNode',p) 
{
y = VSize(u.Location - p.Location);
GetALocalPlayerController().ClientMessage(y);
if(y<100000)
u.Waypoints[l] = p;
}
}
}*/
function bool isclosec()
{
local actor s;
local int y;
s = GetALocalPlayerController().Pawn;
y = VSize(s.Location - self.Location);
if(y<0)
    y*=-1;
 if(y<700)
 {
    return true;
 }
 else 
 return false;
}

simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local actor d;
    local int y;
    local bool a;
    local string pr;
    local string pr1;
    local string pr2;
    local Font previous_font;
    pr = Prompt;
    pr1= Prompt1;
    pr2= Prompt2;
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    a = isclosec();
    d = GetALocalPlayerController().Pawn;
    y = VSize(self.Location - d.Location);
    GetALocalPlayerController().ClientMessage(y);
    if(y<0)
    y*=-1;
    if(a==true && y>300)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(pr); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font;
    }
    if(a==true && y<300)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(pr1); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font;
    }
    else
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(pr2); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font;
    }

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
//Velocity = Normal(Vector(Rotation))*GroundSpeed;
//SetRotation(RInterpTo(Rotation,test,Delta,90000,true));
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
        //findthenode();
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
bPostRenderIfNotVisible=true
   GroundSpeed=200.0
}

