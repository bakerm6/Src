class rotatingferry extends actor
placeable;
/*
Rotating ferris wheel attempt
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var int RotatingSpeed;
var int SpeedFade;
var bool spawnb;
var int x;

//updates each frame
event Tick( float DeltaTime ) 
{
    local Rotator final_rot;
	
    super.Tick(DeltaTime);
	
	final_rot = Rotation;
	
	if(x<12)
    final_rot.pitch = final_rot.pitch + RotatingSpeed*DeltaTime+100;
	
	//final_rot.roll = final_rot.roll - RotatingSpeed*DeltaTime-100;
	SetRotation(final_rot);
	x+=1;
	
	if(x>=12 && x<36)
	{
    final_rot.pitch = final_rot.pitch - RotatingSpeed*DeltaTime-100;
	//final_rot.roll = final_rot.roll + RotatingSpeed*DeltaTime+100;
	SetRotation(final_rot);
	x+=1;
	}
	
	if(x<=36&&x<300)
	{
	x += 1;
	}
	
	if(x==300)
	{
	x = 0;
	}
	
}

defaultproperties
{
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'ferris_anim_testing.ferriswheel_test_box001'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    RotatingSpeed = 1;
    SpeedFade = 10
	
    bHidden = false
    spawnb = true
	x = 0;
}