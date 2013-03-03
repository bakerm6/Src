class waterbottle extends GamePawn
    placeable;
var() StaticMeshComponent StaticMesh;
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
  
   bJumpCapable=false
   bCanJump=false
   bNoDelete = false
   }