Class searchabletrash extends Trigger;
 /*
 Interactable trashcans in Landfall
 allow for variables to be set in editor for custimization
 DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
 */
var() const string Prompt;
var() int bottle;
var() int food;
var() int flashlight;
var() int batteries;
var Soundcue clicky;
//var() StaticMeshComponent StaticMesh;
//var() StaticMeshComponent MyMesh;
var int inty;
var int search;
var bool IsInInteractionRange;
var bool firsttime;
var bool play;
var(Rendertext) Font lf;
//Becomes interactiable when touched
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
 // Untouch removes interaction
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
        if(search == 1)
        {
           search = 2;
        }
    }
}
 //Renders prompts based on state of the trigger
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local Font previous_font;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    if(search == 0)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to search"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    else if(search == 1)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Searched"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    if(firsttime == true)
    {
    if(bottle == 1)
    {
    a.waterbottlec  = a.waterbottlec+1;
    firsttime = false;
    bottle = 2;
    }
    if(food == 1)
    {
    a.foodc = a.foodc+1;
    firsttime = false;
    food = 2;
    }
    if(flashlight == 1)
    {
    a.flashlightc = a.flashlightc+1;
    firsttime = false;
    flashlight = 2;
    }
    if(batteries == 1)
    {
    a.batteryc = a.batteryc+1;
    firsttime = false;
    batteries = 2;
    }
    }
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,325);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(Prompt); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    //firsttime = false;
    }
    if(search == 2)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Searched"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    
}
//when used, use is disabled
//the player is given any item set in defaults
function bool UsedBy(Pawn User)
{
    local bool used;
 
    used = super.UsedBy(User);
 
    if (IsInInteractionRange && search!=2)
    {
        //If it matters, you might want to double check here that the user is a player-controlled pawn.
        search = 1;
        if(play == false)
        {
        PlaySound(clicky);
        play = true;
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
       StaticMesh=StaticMesh'trash_can.Mesh.trashcan'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    clicky = SoundCue'Sounds.clickc'
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bStatic = true
    bPostRenderIfNotVisible=true
    inty = 1
    search = 0
    firsttime = true
    play = false
    lf = Font'Sounds.lffont'
}