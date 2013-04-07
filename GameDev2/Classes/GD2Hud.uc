class GD2Hud extends MobileHUD;
function PostRender()
{	
	local monster DebugPawn;
	local Vector CameraLocation;
	local Rotator CameraRotation;
    local Font previous_font;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
	Super.PostRender();
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    //a.mission1 = true;
    if(a.mission1 == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(600,600);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(a.waterbottlec); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(615,600);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(" X    Watterbottles");
    }
	ForEach DynamicActors(class'monster', DebugPawn)
	{
		AddPostRenderedActor(DebugPawn);
	}

	if (PlayerOwner != None)
	{
		PlayerOwner.GetPlayerViewpoint(CameraLocation, CameraRotation);
		DrawActorOverlays(CameraLocation, CameraRotation);
	}
}

defaultproperties
{
}