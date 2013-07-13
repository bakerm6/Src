class rideop_bumper extends trigger;
/*
Interactable ride booths for the rides in map 2
of Lanfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 05/30/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var bool IsInInteractionRange;
var SoundCue squeek;
var(Rendertext) Font lf;
var int check;

//Debug Print
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}

// When touching the trigger it becomes interactable
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

// An un touch makes the trigger no longer interactable
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
    }
}

// Prompts user to interact with duct tape when touching it
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local Font previous_font;

    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);

    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to turn ride on or off"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;

}

//When used the ride will screech to a halt or start moving
function bool UsedBy(Pawn User)
{
    //DebugPrint("f");
	local bool used;
	local bumpercar bu;
	
    used = super.UsedBy(User);
	
    if (IsInInteractionRange && check == 0)
    {
	//DebugPrint("working");
		
		ForEach AllActors(class'bumpercar',bu)
		{
		//b.TurnOff();
		bu.b= false;
		check = 1;
		}
		
        PlaySound(squeek);
        return true;
    }
	
	else if (IsInInteractionRange && check == 1)
    {
	//DebugPrint("workingagain");
		
		ForEach AllActors(class'bumpercar',bu)
		{
		//b.TurnOff();
		bu.b= True;
		check = 0;
		}
		
        PlaySound(squeek);
        return true;
    }
    return used;
} 

DefaultProperties
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
       StaticMesh=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_SHORT'  //change
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    squeek = SoundCue'Sounds.squeek' //change
	
    bBlockActors=True
    bCollideActors=true
    bHidden=True
    bNoDelete = false
    bStatic = false
	check = 0;
    bPostRenderIfNotVisible=true
	
    lf = Font'EngineFonts.lffont'
}