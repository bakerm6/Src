class TestBot extends GamePawn
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
 End Object
 Begin Object class=StaticMeshComponent Name=MyStaticMeshComponent
    StaticMesh=StaticMesh'EngineMeshes.Cube'
 End Object
  StaticMesh=MyStaticMeshComponent
  Components.Add(MyStaticMeshComponent)
  ControllerClass=class'GameDev2.TestAIController'

    bJumpCapable=false
    bCanJump=false

    GroundSpeed=200.0 //Making the bot slower than the player
}

