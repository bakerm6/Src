class clowngame extends trigger;
/*
Simple trigger for interaacting with a clown game
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var Soundcue laugh;
var bool IsInInteractionRange;
var(Rendertext) Font lf;
var bool blaugh;
var LF_trigger_interaction_prompt movie;

//if the player touches the trigger they can interact with the game
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        IsInInteractionRange = true;
        blaugh = true;
    }
}


// untouching the trigger stops the postrender
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
			blaugh = false;
    }
}

//Prompts user for interaction when touching trigger
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
   /* local Font previous_font;
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to interact"); 
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;*/

    if (movie == None)
    {
        movie = new class'LF_trigger_interaction_prompt';            
	}
	movie.Init();

}
//if used the trigger will play a sound
function bool UsedBy(Pawn User)
{
    local bool used;
 
    used = super.UsedBy(User);
 
    if (IsInInteractionRange)
    {

    PlaySound(laugh);
    blaugh = false;

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
       StaticMesh=StaticMesh'Arcade_packg.arcade_clown_game'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    laugh = SoundCue'Sounds.clown_laughc'
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bStatic = true
    blaugh=true
    bPostRenderIfNotVisible=true
    lf = Font'EngineFonts.lffont'
}
