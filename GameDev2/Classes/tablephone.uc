class tablephone extends trigger;
var int search;
var bool IsInInteractionRange;
var bool firsttime;
var bool play;
var bool playa;
var SoundCue duc;
var SoundCue linesdead;
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
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
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
        /*if(search == 1)
        {
           search = 2;
        }*/
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
    if(search == 0 && a.mission2a == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText("Press E to Investigate"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    a.mission2b = true;
    }
    else if(search == 1 && a.mission2b == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText("Press E to Repair"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    if(search == 2)
    {
    /*previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;*/
    }
    
}

function bool UsedBy(Pawn User)
{
    local bool used;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    //DebugPrint("f");
    used = super.UsedBy(User);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    if (IsInInteractionRange&&search!=2&&a.mission2a==true)
    {
        //DebugPrint("F");
        //If it matters, you might want to double check here that the user is a player-controlled pawn.
        search = 1;
        if(play== false)
        {
        PlaySound(linesdead);
        play = true;
        }
        if(a.duct == 1 && a.wire == 1 && a.strip == 1&& playa == false)
        {
        PlaySound(duc);
        search = 2;
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
       StaticMesh=StaticMesh'FOODCART.Mesh.food_cart'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
    linesdead = SoundCue'Sounds.shitthelineisdeadc'
    duc = SoundCue'Sounds.duct_tapec'
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bStatic = true
    bPostRenderIfNotVisible=true
    search = 0
    firsttime = true
    play = false
    playa = false
}