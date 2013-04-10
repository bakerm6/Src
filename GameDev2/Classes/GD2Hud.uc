class GD2Hud extends MobileHUD;
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
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
    if(a.mission1 == true && a.mission2a == false)
    {
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(a.waterbottlec); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(915,50);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(" X    Watterbottles");
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(900,75);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(a.foodc); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(915,75);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(" X    Food");
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(900,100);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(a.batteryc); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(915,100);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(" X    Batteries");
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(900,125);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(a.flashlightc); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(915,125);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText(" X    Flashlight");
    }
    if(a.mission1 == true && a.mission2a == true)
    {
    //DebugPrint("F");
    previous_font = Canvas.Font;
    Canvas.Font = class'Engine'.Static.GetMediumFont(); 
    Canvas.SetPos(900,50);
    Canvas.SetDrawColor(0,255,0,255);
    Canvas.DrawText("Find a telephone"); //Prompt is a string variable defined in our new actor's class.
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
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