/**
 * Copyright 1998-2012 Epic Games, Inc. All Rights Reserved.
 */
class CustomGameInfo extends GameInfo;

auto State PendingMatch
{
Begin:
	StartMatch();
}

defaultproperties
{
	HUDType=class'GameFramework.MobileHUD'
	PlayerControllerClass=class'CustomGame.CustomPlayerController'
	DefaultPawnClass=class'CustomGame.CustomPawn'
	bDelayedStart=false
}


