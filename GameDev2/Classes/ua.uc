Class ua extends Trigger;
 
var() const string Prompt;
var() int bottle;
//var() StaticMeshComponent StaticMesh;
//var() StaticMeshComponent MyMesh;
var int inty;
var int search;
var bool IsInInteractionRange;
var bool firsttime;
var(RenderText) Font lf;
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
 
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        firsttime = false;
        IsInInteractionRange = false;
    }
}
 
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
    Canvas.Font = lf;;
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
    //a.mission1 = true;
    bottle = 2;
    }
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,325);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText(Prompt); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    //firsttime = false;
    }
    }
    
}

function bool UsedBy(Pawn User)
{
    local bool used;
 
    used = super.UsedBy(User);
 
    if (IsInInteractionRange)
    {
        //If it matters, you might want to double check here that the user is a player-controlled pawn.
        GetALocalPlayerController().ClientMessage("TRIGGER");
        search = 1;
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
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'trash_can.Mesh.trashcan'
    End Object
    //StaticMesh = MyMesh
    //CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    bBlockActors=true
    bHidden=false
    bStatic = false
    bPostRenderIfNotVisible=true
    inty = 1
    search = 0
    firsttime = true
    lf = Font'EngineFonts.lffont'
}