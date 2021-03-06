class strength extends trigger;
/*
Interactable strength machine in Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialze variables
var Soundcue bell;
var bool IsInInteractionRange;
var bool bbell;
var(Rendertext) Font lf;
var LF_trigger_interaction_prompt movie;

//becomes interactable when touched
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        IsInInteractionRange = true;
        bbell=true;
    }
}

 //interactability lost when untouched
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
		if(movie != none)
		{
			movie.End();
		}

        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
        bbell = false;
    }
}

//Renders propmt if interactable
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    /*local Font previous_font;
	
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to interact"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;*/

	if (movie == None)
    {
        movie = new class'LF_trigger_interaction_prompt';            
	}
	movie.Init();
}

//plays sound when used
function bool UsedBy(Pawn User)
{
    local bool used;
 
    used = super.UsedBy(User);
 
    if (IsInInteractionRange)
    {
        //If it matters, you might want to double check here that the user is a player-controlled pawn.
    if(bbell == true)
    {
    PlaySound(bell);
    bbell=false;
    }
        //Put your own sound cue here. And ideally, don't directly reference assets in code.
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
	
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'strength_test_pkg.Mesh.strength_test'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    bell = SoundCue'Sounds.bellc'
	
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bStatic = true
    bbell = true
    bPostRenderIfNotVisible=true
	
    lf = Font'EngineFonts.lffont'
}