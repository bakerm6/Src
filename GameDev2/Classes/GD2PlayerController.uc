class GD2PlayerController extends PlayerController;

/*
Player controller class for Landfall
Bool are used to check for attack syncing for exec functions
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//variable declarations 
var SoundCue attackh;
var SoundCue attackm;
var SoundCue heartb;
var SoundCue heartf;
var SoundCue crows;
var SoundCue flashlights;
var SoundCue findphone;
var SoundCue power;
var SoundCue gotopier;
var SoundCue mgrunt;
var int mapc;
var bool flashb;
var bool mission2start;
var bool mission3start;
var bool done;
var bool canattack;
var bool canblock;
var bool checka;
var bool checkb;
var bool onepress;
var bool hit;


//Function to output debug messages
simulated private function DebugPrint(string sMessage)
{
		GetALocalPlayerController().ClientMessage(sMessage);
}


	
//Allocates timers for ambient soundcues and mission objective soundcues
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    local LF_options_save_info options;
    local PostProcessChain Chain;
    local PostProcessEffect Effect;
    local int index;
    local testweapon fp_arms;
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	super.Possess(inPawn, bVehicleTransition);

	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);
	crowp();
	flash();
	SetTimer(1.94,true,'play');
	SetTimer(1.46,true,'playf');
	SetTimer(87,true,'crowp');
	SetTimer(2,true,'flash');
	SetTimer(2,true,'mission2s');
	SetTimer(2,true,'mission3s');
	SetTimer(10,true,'quitg');
	SetTimer(15,true,'endgame');
	options = class'LF_options_save_info'.static.load_options();

		if(options == none)
		{
			options = new class'LF_options_save_info';
		}

	ConsoleCommand("setSensitivity"@options.CursorSensitivity);
	index = options.AAIndex;
	Chain = WorldInfo.WorldPostProcessChain;

		if (Chain != None)
		{
			foreach Chain.Effects(Effect)
			{
				if (UberPostProcessEffect(Effect) != None)
				{
					switch(index)
					{
						case 0:
							
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_Off;
							ConsoleCommand("PostProcessAAType 0");
							break;
						case 1:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA1;
							ConsoleCommand("PostProcessAAType 1");
						   
							break;
						case 2:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA2;
							ConsoleCommand("PostProcessAAType 2");
						  
							break;
						case 3:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA3;
							ConsoleCommand("PostProcessAAType 3");
						
							break;
						case 4:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA4;
							ConsoleCommand("PostProcessAAType 4");
						   
							break;
						case 5:
							UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA5;
							ConsoleCommand("PostProcessAAType 5");
						 //`log( UberPostProcessEffect(Effect).PostProcessAAType);
						
							break;
					}
             
				}
			}
		}

		if(LF_Pawn.flashlightc == 1)
		{
			fp_arms = Spawn(class'testweapon');
			LF_Pawn.InvManager.addInventory(fp_arms);
			LF_Pawn.InvManager.bMustHoldWeapon = true;
			//`log(p.InvManager.InventoryChain);
		}
}

//function check to see if mission 5 is completed
function endgame()
{
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);
	
	if(LF_Pawn.mission5 == true)
	{
		PlaySound(gotopier);
		cleartimer('endgame');
	}
}


//Plays soundcue for starting mission 3 if player pawn returns mission 3 true
function mission3s()
{
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);


	if(LF_Pawn.mission3 == true && mission3start == false)
	{
		PlaySound(power);
		mission3start = true;
	}
}


//Plays soundcue for starting mission 2 if player pawn returns mission 2 true
function mission2s()
{
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);

	if(LF_Pawn.mission2a == true && mission2start == false)
	{
		PlaySound(findphone);
		mission2start = true;
	}

}


//Checks for possesion of the flashlight and clears itself once the player aquires one
function flash()
{
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);

	if(LF_Pawn.flashlightc == 1 && flashb == false && LF_Pawn.mission2a == false)
	{
	//DebugPrint(1);
		PlaySound(flashlights);
		flashb = true;
		ClearTimer('flash');
	}
}


//Plays ambient crow sound
function crowp()
{
	PlaySound(crows);
}


//plays heartbeat
function play()
{
	if(GD2PlayerPawn(Pawn).Health > 300 && GD2PlayerPawn(Pawn).Health < 700)
	{
		PlaySound(heartb);
	}
}

//plays fast heartbeat
function playf()
{
	if(GD2PlayerPawn(Pawn).Health <= 300&& GD2PlayerPawn(Pawn).Health > 0)
	{
		PlaySound(heartf);
	}
}

//Gets the triggers that the player uses
function GetTriggerUseList(float interactDistanceToCheck, float crosshairDist, float minDot, bool bUsuableOnly, out array<trigger> out_useList)
{
    local int Idx;
    local vector cameraLoc;
    local rotator cameraRot;
    local trigger checkTrigger;
    local SeqEvent_Used UseSeq;
 
    if (Pawn != None)
    {
        GetPlayerViewPoint(cameraLoc, cameraRot); 
        // search of nearby actors that have use events 
        foreach Pawn.CollidingActors(class'trigger',checkTrigger,interactDistanceToCheck) 
        { 
        for (Idx = 0; Idx < checkTrigger.GeneratedEvents.Length; Idx++)
			{
				UseSeq = SeqEvent_Used(checkTrigger.GeneratedEvents[Idx]);

				if( ( UseSeq != None )
					// if bUsuableOnly is true then we must get true back from CheckActivate (which tests various validity checks on the player and on the trigger's trigger count and retrigger conditions etc)
					&& ( !bUsuableOnly || ( checkTrigger.GeneratedEvents[Idx].CheckActivate(checkTrigger,Pawn,true)) )
					// check to see if we are looking at the object
					&& ( Normal(checkTrigger.Location-cameraLoc) dot vector(cameraRot) >= minDot )

					
					&& ( ( ( UseSeq.bAimToInteract && IsAimingAt( checkTrigger, 0.98f ) && ( VSize(Pawn.Location - checkTrigger.Location) <= UseSeq.InteractDistance ) ) )
					      // if we should NOT aim to interact then we need to be close to the trigger
			  || ( !UseSeq.bAimToInteract && ( VSize(Pawn.Location - checkTrigger.Location) <= UseSeq.InteractDistance ) )  // this should be UseSeq.InteractDistance
						  )
				   )
				{
					out_useList[out_useList.Length] = checkTrigger;

					// don't bother searching for more events
					Idx = checkTrigger.GeneratedEvents.Length;
				}
			}
          
 
            //add usable actors to the list
            if (searchabletrash(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
            if (searchablefoodcart(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
             if (tablephone(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
            if (ducttape(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
            if (wire(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
            if (strips(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
            if (clowngame(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
            if (flash(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
             if (puzzlet(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
               if (w_fountain(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
            if (strength(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (rideop_bumper(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (rideop_matine(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (door_test(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
			if (panel(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
        }
    }
}

//Exits to main menu
function quit()
{
	ConsoleCommand("open betamen_1");
}


///////////////////////////////////////////////////////////////////////
//"sprinting"
exec function sprinting()
{
	local GD2PlayerPawn LF_Pawn;
	local actor playerpawn;
	
	playerpawn = GetALocalPlayerController().Pawn;
	LF_Pawn = GD2PlayerPawn(playerpawn);
	
	LF_Pawn.GroundSpeed = 300;
	SetTimer(7,false,'stamina');
	SetTimer(1,false,'heart_rate');
	//DebugPrint("sprint");
}

//stamina function to not allow unlimited sprint
function stamina()
{
	local GD2PlayerPawn LF_Pawn;
	local actor playerpawn;
	
	playerpawn = GetALocalPlayerController().Pawn;
	LF_Pawn = GD2PlayerPawn(playerpawn);
	
	LF_Pawn.GroundSpeed = 100;
}
	
	//sprinting increases heart rate slightly
function heart_rate()
{
	local GD2PlayerPawn LF_Pawn;
	local actor playerpawn;
	
	playerpawn = GetALocalPlayerController().Pawn;
	LF_Pawn = GD2PlayerPawn(playerpawn);
	
	LF_Pawn.health -= 50;
}



//walk speed reset
exec function walking()
{
	local GD2PlayerPawn LF_Pawn;
	local actor playerpawn;
	
	playerpawn = GetALocalPlayerController().Pawn;
	LF_Pawn = GD2PlayerPawn(playerpawn);
	
	LF_Pawn.GroundSpeed = 100;
	ClearTimer('stamina');
	//DebugPrint("walk");
}



///////////////////////////////////////////////////////////////////////
//combat function that exectues when z or left mouse is pressed
exec function  attackb()
{
	local monster ai;
	local monsteridle aidle;
	local float dot1;
	local float dot2;
	local vector v;
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	local int Distance;
	local int Distance1;
	
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn = GD2PlayerPawn(Player_Location_Actor);
	v = Vector(LF_Pawn.Rotation);
	//k =testweapon(owner);
	GD2PlayerPawn(Pawn).blockbb = false;

	if (canattack == true)
	{
	checka = true;
	//k.Attack.PlayCustomAnim('FP_attack',1.0);
		ForEach AllActors(class'monster',ai)
		{
			Distance = VSize(Player_location_actor.Location - ai.Location);
			dot1 =v dot (Player_location_actor.Location - ai.Location);
		//DebugPrint(dot1);
			if(Distance<0)
			{
				Distance*=-1;
			}
			
			if(Distance>175&&Distance<350&&dot1 < 0)
			{
			//PlaySound(attackh);
				ai.monster_health-=10;
				hit = true;
				SetTimer(1.25,false,'grunter');
				ai.dead();
			}
			
			if(Distance < 175&&dot1 < 0)
			{
				ai.monster_health-=10;
				hit = true;
				SetTimer(1.25,false,'grunter');
				LF_Pawn.health -= 25;
				ai.dead();
			}
		}

		ForEach AllActors(class'monsteridle',aidle)
		{
			Distance1 = VSize(Player_location_actor.Location - aidle.Location);
			dot2 =v dot (Player_location_actor.Location - aidle.Location);
		//DebugPrint(dot1);
		
			if(Distance<0)
			{
				Distance*=-1;
			}
				
			if(Distance1>175&&Distance1<350&&dot2 < 0)
			{
			//PlaySound(attackh);
				aidle.monster_health-=10;
				SetTimer(1.25,false,'grunter');
				aidle.dead();
			}
		}
		
		//PlaySound(attackm);
		canattack = false;
		await();
	}
}



//plays a grunting sound when hit
function grunter()
{
	PlaySound(mgrunt);
	hit = false;
}



//function to sync animation with attack
function await()
{
	SetTimer(1.25,false,'waiter');
	SetTimer(0.8,false,'noisea');
}


//plays an attack miss sound if you are not hitting an object
function noisea()
{
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);
	
	if(LF_PAwn.flashlightc == 1&&hit == false)
	{
	PlaySound(attackm);
	}
}
//resets bools for animation blend
function waiter()
{
	canattack = true;
	checka = false;
}
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////


//loads a level when the player dies
function quitg()
{
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);
	
//DebugPrint(MyMapName);
	if(LF_Pawn.health <=0)
	{
	//ConsoleCommand("quit");
		if(mapc == 1)
		{
		//DebugPrint("b");
		ConsoleCommand("open base.udk");
		}
		if (mapc == 2)
		{
		ConsoleCommand("open base2.udk");
		//ConsoleCommand("quit");
		}
	
	}
}



///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
//block function that executes when c or right mouse is pressed////////
exec function blockb()
{
	local float dot1;
	local float dot2;
	local vector v;
	local GD2PlayerPawn LF_Pawn;
	local monster ai;
	local monsteridle aidle;
	local actor Player_location_actor;
	local int Distance;
	local int Distance1;

	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);
	v = Vector(LF_Pawn.Rotation);
	
	if(LF_Pawn.flashlightc == 1 && LF_Pawn.batteryc == 1&&onepress == true)
	{
		LF_Pawn.TriggerRemoteKismetEvent('flashlight_toggle' );
		onepress = false;
		SetTimer(1.4,false,'flashon');
	}
	
	if(canblock == true)
	{
		checkb = true;
		ForEach AllActors(class'monster',ai)
		{
			Distance = VSize(Player_location_actor.Location - ai.Location);
			dot1 =v dot (Player_location_actor.Location - ai.Location);
		
			if(Distance<0)
			{
				Distance*=-1;
			}
			
			if(Distance<700 && Distance<350 &&dot1 < 0)
			{
				blockingtime();
			}
			
			else
			{
				GD2PlayerPawn(Pawn).blockbb = false;
			}
		}

		ForEach AllActors(class'monsteridle',aidle)
		{
			Distance1 = VSize(Player_location_actor.Location - aidle.Location);
			dot2 =v dot (Player_location_actor.Location - aidle.Location);
		//DebugPrint(dot1);
			if(Distance<0)
			{
				Distance*=-1;
			}
			
			if(Distance1<700 && Distance1<350 &&dot2 < 0)
			{
				blockingtime();
			}
			
			else
			{
				GD2PlayerPawn(Pawn).blockbb = false;
			}
		}
		
	canblock = false;
	bwait();
	}
}


//syncs block animation
function bwait()
{
	SetTimer(1.4,false,'blockwaiter');
}

function blockwaiter()
{
	canblock = true;
	checkb = false;
}

function blockingtime()
{
	GD2PlayerPawn(Pawn).blockbb = true;
	SetTimer(1.4,false,'resetblock');
}


//resets block ability when animation is done
function resetblock()
{
	GD2PlayerPawn(Pawn).blockbb = false;
}


///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

//turns flashlight on/off
function flashon()
{
	local GD2PlayerPawn LF_Pawn;
	local actor Player_location_actor;
	
	onepress = true;
	Player_location_actor = GetALocalPlayerController().Pawn;
	LF_Pawn  = GD2PlayerPawn(Player_Location_Actor);
	
	LF_Pawn.TriggerRemoteKismetEvent('flashlight_toggle' );
}

//opens the credits
function endgamescene()
{
	consolecommand("open credits.udk");
} 

//testing kismet
function k_mat_test()
{
	DebugPrint("working");
}

///////////////////////////////////////////////////////////////////////
defaultproperties
{
   InputClass = class'GameDev2.LFPlayerInput'
   CameraClass= class'GameDev2.GD2PlayerCamera'
   

   attackh =  SoundCue'Sounds.attack_hit_cue'
   attackm =  SoundCue'Sounds.attack_miss_cue'
   heartb =  SoundCue'Sounds.heart_beatfixc'
   heartf =  SoundCue'Sounds.heart_beat_fastfixc'
   crows = SoundCue'Sounds.crowsc'
   flashlights = SoundCue'Sounds.hmmaflashlightc'
   findphone = SoundCue'Sounds.findaphonec'
   power = SoundCue'Sounds.letsgetthepoweronc'
   gotopier = Soundcue 'Sounds.ineedtogetoutc'
   //level = SoundCue'Sounds.windc'
   mgrunt = SoundCue'Sounds.mgruntc'
   
   
   done = false;
   flashb = false;
   bIsPlayer = true
   mission2start = false;
   bCollideActors=true
   canattack = true
   canblock = true
   checka = false
   checkb = false
   onepress = true
   hit = false
   // bBehindView=false
   // bForceBehindView=false
   
   mapc = 1;
}
