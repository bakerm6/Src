class w_fountain extends trigger;
/*
Interactable water fountain in Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var Soundcue water;
var bool IsInInteractionRange;
var(Rendertext) Font lf;



//Can be interacted with when touched
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
        //Ideally, we should also check that the touching pawn is a player-controlled one.
        PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        IsInInteractionRange = true;
    }
}


//No longer interactable when touched
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
    }
}

//Renders prompt if interactable
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local Font previous_font;
	
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to interact"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
}

//Plays sound when used
function bool UsedBy(Pawn User)
{
    local bool used;
 
    used = super.UsedBy(User);
 
    if (IsInInteractionRange)
    {
      
    PlaySound(water);
       
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
       StaticMesh=StaticMesh'water_fountain_pkg.Mesh.water_fountain'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    water = SoundCue'Sounds.wfountainc'
	
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bStatic = true
    bPostRenderIfNotVisible=true
	
    lf = Font'EngineFonts.lffont'
	
}
