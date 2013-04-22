class rotatingferry extends actor
placeable;
var int RotatingSpeed;
var int SpeedFade;
var rotator final_rot;
var bool spawnb;
event Tick( float DeltaTime ) 
{
    //local Rotator final_rot;
    super.Tick(DeltaTime);
    if(spawnb == true)
    {
    final_rot = Rotation;
    spawnb = false;
    }
    //final_rot = Rotation;
    if(final_rot.pitch > 3000 || final_rot.pitch < -3000 );
    final_rot.pitch = 0;
    //RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
	//final_rot.pitch = final_rot.pitch - RotatingSpeed*DeltaTime;
    
    if(final_rot.pitch < -3000)
    final_rot.pitch +=1;
    if(final_rot.pitch > 3000)
    final_rot.pitch -=1;
    //final_rot.pitch = final_rot.pitch - RotatingSpeed*DeltaTime-100;
	SetRotation(final_rot);
}
defaultproperties
{
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'ferris_anim_testing.ferriswheel_test_box001'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
       RotatingSpeed = 2000
    SpeedFade = 1
    bHidden = false
    spawnb = true
}