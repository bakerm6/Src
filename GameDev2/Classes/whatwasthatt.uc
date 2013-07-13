Class whatwasthatt extends Trigger;

 /*
Dialogue trigger in Landfall
allow for variables to be set in editor for custimization
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
 
//initialize variables
var bool played;
var SoundCue what;

//Play audio on first touck
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none&&played == false)
    {
        PlaySound(what);
        
    }
}

//Once untouched the play bool is set to true
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
    played = true;
    }
}

DefaultProperties
{
Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
 
    Begin Object Class=StaticMeshComponent Name=MyMesh
        StaticMesh=StaticMesh'NodeBuddies.3D_Icons.NodeBuddy__BASE_SHORT'
    End Object
 
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    what = SoundCue'Sounds.whatwasthatc'
	
    bBlockActors=false
    bHidden=true
    played = false
    bPostRenderIfNotVisible=true
}