class switchtomap2 extends trigger;
 /*
Trigger to load next stage in Landfall
 DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
        Consolecommand("open base.udk");

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
	
    //what = SoundCue'Sounds.whatwasthatc'
    bBlockActors=false
    bHidden=true
    //played = false
    bPostRenderIfNotVisible=true
	
}