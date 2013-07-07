class GD2Flashlight extends UTWeap_ShockRifle;
/*
Flashlight
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/
//initialize variables
var float LightAttachInterval;
var float LightOnInterval;
var bool IsLightOn;
var SpotLightComponent LightAttachment;
var name LightSocket;


//////////////////////////////////////////////////////
//checks for usage
exec function Fire() 
{
	if (IsLightOn) 
		LightAnimOff();
	else
		LightAnimOn();
}

function LightAnimOn()
{
	SetTimer(LightOnInterval,false,'LightIsOn');
}

function LightAnimOff()
{
	SetTimer(LightOnInterval,false,'LightIsOff');
}

function LighIsOn()
{
	IsLightOn=true;
	SkeletalMeshComponent(Mesh).AttachComponentToSocket(LightAttachment,LightSocket);
	setTimer(2.0,false);
}

function LightIsOff() 
{
	IsLightOn = false;
	SkeletalMeshComponent(Mesh).DetachComponent(LightAttachment);
	setTimer(LightAttachInterval,false,'inactive');
}
//////////////////////////////////////////////////////
defaultproperties
{
	AttachmentClass=class'GD2FlashlightAttachment'
	MuzzleFlashLightClass = class'UDKExplosionLight'
	InstantHitDamageTypes(0)=class'UTDamageType'
		begin object Class=SpotLightComponent Name=TorchLightComponent
end object
	LightAttachment=TorchLightComponent
LightSocket="LightSocket"

}
