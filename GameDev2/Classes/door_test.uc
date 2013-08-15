class door_test extends trigger
placeable;

/*
Door test class in Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var int RotatingSpeed;
var int SpeedFade;

// 0 = closed, 1 = opening, 2 = opened, 3 = closing
var int status;
var bool IsInInteractionRange;
var bool playing;

var(Rendertext) Font lf;

var Soundcue door_open;
var Soundcue door_close;

//Debug Function
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}

//When used, the door will either open or close depending on status.
event Tick( float DeltaTime ) 
{
    local Rotator final_rot;
    super.Tick(DeltaTime);

		if(status == 1)
		{
			final_rot = Rotation;
			RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
			final_rot.Yaw = final_rot.Yaw + RotatingSpeed*DeltaTime;
			SetRotation(final_rot);
		}
		if(status == 2)
		{
			final_rot = Rotation;
			RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
			final_rot.Yaw = final_rot.Yaw - RotatingSpeed*DeltaTime;
			SetRotation(final_rot);
		}
	
}

//When touched can interact
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        IsInInteractionRange = true;
        //DebugPrint("here");
    }
}

//Interactability lost on untouch
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
        /*if(status == 1)
        {
           status = 2;
        }*/
    }
}
//Renders propmt if interactable
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local Font previous_font;
   // local actor Player_Location_Actor;
   // local GD2PlayerPawn a;
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press Use to Open"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;


}
//Sets the status and plays the appropriate sound.
function bool UsedBy(Pawn User)
{
    local bool used;
    //DebugPrint("f");
    used = super.UsedBy(User);

		if(playing == true)
		{
			return used;
		}
		
		if (IsInInteractionRange&&status!=1&&status!=3)
		{
			status = 1;
			playing = true;
			PlaySound(door_open);
			SetTimer(5.5,false,'door_stop');
      
			return true;
		}

		if (IsInInteractionRange&&status==3)
		{
			status = 2;
			playing = true;
			PlaySound(door_close);
			SetTimer(5.5,false,'door_stop');

			return true;
		}

    return used;
} 

function door_stop()
{

	if(status == 2)
	{
		status = 0;
	}

	if(status == 1)
	{
		status = 3;
	}
	playing = false;

}

defaultproperties
{
  Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
	
    Begin Object Name=CollisionCylinder
       CollisionHeight =40.000000
       CollisionRadius=20.00000
    End Object
    CylinderComponent=CollisionCylinder
	
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'door_tester.door_simple'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    RotatingSpeed = 6000
    SpeedFade = 1
	
	bHidden = false
    bBlockActors=true
    bCollideActors=true
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
	
    status = 0
	playing = false
    lf = Font'EngineFonts.lffont'
	
	door_open = SoundCue'Sounds.creek_openc'
	door_close = SoundCue'Sounds.door_closec'
}
