class monster extends GamePawn
    placeable;
var() StaticMeshComponent StaticMesh;
var() array<Pathnode> Waypoints;
var () int healtht;
event PostBeginPlay()
{
 super.PostBeginPlay();
}

DefaultProperties
{
 Begin Object Name=CollisionCylinder
       CollisionHeight =+44.000000
       CollisionRadius=+20.00000
 End Object
 CylinderComponent=CollisionCylinder
 Begin Object class=StaticMeshComponent Name=MyStaticMeshComponent
    StaticMesh=StaticMesh'EngineMeshes.Cube'
 End Object
  StaticMesh=MyStaticMeshComponent
  Components.Add(MyStaticMeshComponent)
  ControllerClass=class'GameDev2.monsterai'

   bJumpCapable=false
   bCanJump=false
   bNoDelete = false
   //bNoStatic = false
    GroundSpeed=200.0 //Making the bot slower than the player
}

