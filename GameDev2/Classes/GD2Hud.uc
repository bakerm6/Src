class GD2Hud extends MobileHUD;
function PostRender()
{	
	local monster DebugPawn;
	local Vector CameraLocation;
	local Rotator CameraRotation;

	Super.PostRender();

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