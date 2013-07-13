Class puzzlet extends Trigger;
 /*
Trigger for the power puzzle in Landfall
 DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
 */
 
//initialize variable
var bool IsInInteractionRange;

//on touch becames interactable
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

//On untouch lose interaction ability
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
    }
}

//allows for use
function bool UsedBy(Pawn User)
{
    local bool used;
 
    used = super.UsedBy(User);
 
    if (IsInInteractionRange)
    {
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
	
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bStatic = true
    bPostRenderIfNotVisible=true
}