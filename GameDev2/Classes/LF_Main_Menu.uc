class LF_Main_Menu extends GFxMoviePlayer;
//z inputs
var LFPlayerInput LFInput;

//================BINDING STUFF==================
var bool bCaptureForBind;
var name CapturedKey;
var array<UTUIDataProvider_KeyBinding> Binded, Blank;
//var int SelectedIndex;
var name CapturedBind;
var string DuplicateBindName;
var bool bDublicateBindDetected;
var GFxClikWidget M_Volume_Slider, res_men, bright_level;
var GFxObject BindingMovie, BindKeyTF, DuplicateMovieTF, DuplicateTitleTF;
var GFxObject at_bind, bl_bind, menu_bind;
var bool bConfirmChoice, bPendingUnbind;
var string bind_at, bind_bl, bind_menu;
var string current_bind_cmd;
var LF_options_save_info options_save_info;
//==================================================


function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
	LFInput = LFPlayerInput(GetPC().PlayerInput);
	
}
function load_options_save_info()
{
	options_save_info = class'LF_options_save_info'.static.load_options();
	if(options_save_info == none)
	{
		options_save_info = new class'LF_options_save_info';
	}
}

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{
`log(WidgetName);
	switch(WidgetName)
	{
		case ('master_v'):
			M_Volume_Slider = GFxClikWidget(Widget);
			M_Volume_Slider.AddEventListener('CLIK_valueChange', volume_change);
			M_Volume_Slider.SetFloat("value", options_save_info.MasterVolume);
			break;
		case ('bright_lvl'):
			bright_level = GFxClikWidget(Widget);
			bright_level.AddEventListener('CLIK_buttonClick', lf_change_bright);
			//bright_Level.SetFloat("value", options_save_info.Brightness);
			break;
		default:
			break;
	}
	return True;
}
function lf_change_bright(GFxClikWidget.EventData ev)
{
	`log("b_called");
}
function volume_change(GFxClikWidget.EventData ev)
{
	GetPC().SetAudioGroupVolume('Master',M_Volume_Slider.GetFloat("value"));
	options_save_info.MasterVolume = M_Volume_Slider.GetFloat("value");
	options_save_info.save_options();
	//`log(options_save_info.MasterVolume);
}

function ControlOptionsOpened()
{
	//`log("stuff happend");
	BindingMovie = GetVariableObject("_root.dupeMC");
	UpdateDataProvider();
	at_bind = GetVariableObject("_root.attack_bind");
	bl_bind = GetVariableObject("_root.block_bind");
	menu_bind = GetVariableObject("_root.menu_bind");
	LFInput = LFPlayerInput(GetPC().PlayerInput);
	load_options_save_info();
}

//updates list in flash with binding info
function UpdateDataProvider()
{
	local int i, BindingIdx;
	local String GBA_BindValue;
	//contains key-bind information
	local array<UDKUIResourceDataProvider> ProviderList;
	at_bind = GetVariableObject("_root.attack_bind");
	//`log(at_bind);
	bl_bind = GetVariableObject("_root.block_bind");
	menu_bind = GetVariableObject("_root.menu_bind");
	LFInput = LFPlayerInput(GetPC().PlayerInput);
	if(LFInput==none)
		return;
	//blank is an empty object thing
	Binded=Blank;
	//loads keybinds into a list(array)
	class'UDKUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'UTUIDataProvider_KeyBinding', ProviderList);
	for(i=0; i<ProviderList.Length; i++)
	{  
		//binded is a array of LFUIProvideer objects
		Binded.InsertItem(0, UTUIDataProvider_KeyBinding(ProviderList[i]));
	}


	for(i=0; i<Binded.Length; i++)
	{
		//`log(Binded[i].Command);
		if(Binded[i].Command == "GBA_attack" || Binded[i].Command == "GBA_block" || Binded[i].Command == "GBA_mainmenu" )
		{
		//loops through the binded list and finds the bind value associated to the name
		for(BindingIdx=0; BindingIdx<LFInput.Bindings.Length; BindingIdx++)
		{
			if(LFInput.Bindings[BindingIdx].Command == Binded[i].Command)
			{
					//Still need block and menu
					GBA_BindValue = String(LFInput.Bindings[BindingIdx].Name);
					//`log(GBA_BindValue);
					if(Binded[i].Command == "GBA_attack")
					{
						if(GBA_BindValue == "F1")
						{
							at_bind.SetText("F One");
						}
						else if(GBA_BindValue == "F2")
						{
							at_bind.SetText("F Two");
						}
						else if(GBA_BindValue == "F3")
						{
							at_bind.SetText("F Three");
						}
						else if(GBA_BindValue == "F4")
						{
							at_bind.SetText("F Four");
						}
						else if(GBA_BindValue == "F5")
						{
							at_bind.SetText("F Five");
						}
						else if(GBA_BindValue == "F6")
						{
							at_bind.SetText("F Six");
						}
						else if(GBA_BindValue == "F7")
						{
							at_bind.SetText("F Seven");
						}
						else if(GBA_BindValue == "F8")
						{
							at_bind.SetText("F Eight");
						}
						else if(GBA_BindValue == "F9")
						{
							at_bind.SetText("F Nine");
						}
						else if(GBA_BindValue == "F10")
						{
							at_bind.SetText("F Ten");
						}
						else if(GBA_BindValue == "F12")
						{
							at_bind.SetText("F Twelve");
						}
						else if(GBA_BindValue == "one")
						{
							at_bind.SetText("One");
						}
						else if(GBA_BindValue == "two")
						{
							at_bind.SetText("Two");
						}
						else if(GBA_BindValue == "three")
						{
							at_bind.SetText("Three");
						}
						else if(GBA_BindValue == "four")
						{
							at_bind.SetText("Four");
						}
						else if(GBA_BindValue == "five")
						{
							at_bind.SetText("Five");
						}
						else if(GBA_BindValue == "six")
						{
							at_bind.SetText("Six");
						}
						else if(GBA_BindValue == "seven")
						{
							at_bind.SetText("Seven");
						}
						else if(GBA_BindValue == "eight")
						{
							at_bind.SetText("Eight");
						}
						else if(GBA_BindValue == "nine")
						{
							at_bind.SetText("Nine");
						}
						else if(GBA_BindValue == "zero")
						{
							at_bind.SetText("Zero");
						}
						else if(GBA_BindValue == "LeftMouseButton")
						{
							at_bind.SetText("Left\nMouse");
						}
						else if(GBA_BindValue == "RightMouseButton")
						{
							at_bind.SetText("Right\nMouse");
						}
						else
						{
						at_bind.SetText(GBA_BindValue);
						}
					}
					if(Binded[i].Command == "GBA_block")
					{
						if(GBA_BindValue == "F3")
						{
							bl_bind.SetText("F Three");
						}
						else
						bl_bind.SetText(GBA_BindValue);
					}
					if(Binded[i].Command == "GBA_mainmenu")
					{
						if(GBA_BindValue == "F3")
						{
							menu_bind.SetText("F Three");
						}
						else
						menu_bind.SetText(GBA_BindValue);
					}
					
			}
		}
		}
	}
}
//click item in flash list
/*function OnListItemPressed(GFxClikWidget.EventData ev)
{
	OpenBindKeyMovie(ev.index);
}*/

function OpenBindKeyMovie(string bind_name)
{

	current_bind_cmd = bind_name;
	BindingMovie.GotoAndStopI(2);
	BindKeyTF = GetVariableObject("_root.dupeMC.dupeTF");
	if(bind_name == "GBA_attack")
	{
		bind_name = "Attack";
	}
		if(bind_name == "GBA_block")
	{
		bind_name = "Block";
	}
		if(bind_name == "GBA_mainmenu")
	{
		bind_name = "Main Menu";
	}
	

	BindKeyTF.SetText("Press The Key\n you want to use for\n" $ bind_name);
	bCaptureForBind=true;
}
// returns friendly name
/*function string GetBindName(int FindIndex)
{
	return Binded[FindIndex].FriendlyName;
}*/
//when input cap is called this runs and reads the key you binds
event bool FilterButtonInput(int ControllerId, name ButtonName, EInputEvent InputEvent)
{
	super.FilterButtonInput(ControllerID,ButtonName,InputEvent);

	if(bCaptureForBind==true && InputEvent == IE_Pressed)
	{
		bCaptureForBind=false;

		//If We Hit Escape, Abort Keybind.
		if(ButtonName=='Escape')
		{
			ReturnToList();
			return true;
		}

		CapturedKey=ButtonName;
		CapturedBind=ButtonName;
		if(CheckForDuplicateKey())
		{
			bDublicateBindDetected=true;
			OpenDuplicateBindMovie(ButtonName, DuplicateBindName);
			return true;
		}
		else
		{
			CheckBind();
			ReturnToList();
			return true;
		}
	}
	CapturedKey='';

	if(bConfirmChoice && InputEvent == IE_Pressed)
	{
		bDublicateBindDetected=false;
		ReturnToList();
	}
	return false;
}

function ReturnToList()
{
	BindingMovie.GotoAndStopI(1);
}

function bool CheckForDuplicateKey()
{
	local int i, BindingIdx;
	local name BindingName;
	local String Command;
	

	if(LFInput==none)
		return false;

	for(BindingIdx=0; BindingIdx<LFInput.Bindings.Length; BindingIdx++)
	{
		BindingName = LFInput.Bindings[BindingIdx].Name;
		//`log(CapturedKey@BindingName);
		if(CapturedKey==BindingName)
		{
			//`log("Found");
			Command=LFInput.Bindings[BindingIdx].Command;
			if(Command!=current_bind_cmd)
			{
			//`log("Found Again");
				for(i=0; i<Binded.Length; i++)
				{
				`log(LFInput.Bindings[BindingIdx].Command@Binded[i].Command);
					if(LFInput.Bindings[BindingIdx].Command == Binded[i].Command)
					{
						DuplicateBindName = String(Binded[i].Name);
						return true;
					}
				}
			}
			if(LFInput.Bindings[BindingIdx].Command == current_bind_cmd)
			{
				DuplicateBindName = String(LFInput.Bindings[BindingIdx].Name);
				return true;
			}
		}
	}
	return false;
}

function OpenDuplicateBindMovie(name BindKeyName, string BindFriendlyName)
{
	BindingMovie.GotoAndStopI(2);
	bConfirmChoice=true;
	//DuplicateTitleTF = GetVariableObject("_root.dupeMC.dupetitle");
	//DuplicateMovieTF = GetVariableObject("_root.dupeMC.dupeTF");
	
	if(string(BindKeyName) != BindFriendlyName)
	{
		//`log("Enetered"@BindKeyTF);
		//DuplicateTitleTF.SetText("Duplicate Keybind");
		BindKeyTF.SetText(BindKeyName$" Is Already\n Bound To\n "$BindFriendlyName$" Press any \n Key to \nContinue");
	}
	
}

//deletes any existing bind to the target key and sets the new target key
function CheckBind()
{
	local int BindingIdx;

	if(LFInput == none)
		return;
	if(bDublicateBindDetected)
	{
		bDublicateBindDetected=false;
		return;
	}
	for(BindingIdx=0; BindingIdx<LFInput.Bindings.Length; BindingIdx++)
	{
		if(LFInput.Bindings[BindingIdx].Command == current_bind_cmd)
		{
			if(CapturedKey == LFInput.Bindings[BindingIdx].Name)
			{
				RemoveBind(BindingIdx);
				return;
			}
			else
			{
				ReturnToList();
			}
		}
	}
	SetNewBind(CapturedKey, current_bind_cmd);
}
//removes
function RemoveBind(int RemovalIndex)
{
	if(LFInput == none)
		return;
	
	LFInput.Bindings.Remove(RemovalIndex, 1);
	UpdateDataProvider();
	LFInput.SaveConfig();
}

function SetNewBind(name Key, string Command)
{
	local KeyBind NewBind;
	local int BindingIdx;
	local bool bGamepad;

	if(LFInput == none)
		return;

	bGamepad = (InStr(Locs(Key), "xboxtypes") != -1 || InStr(Locs(Key), "gamepad") != -1) ? true : false;

	for(BindingIdx=0; BindingIdx < LFInput.Bindings.Length; BindingIdx++)
	{
		if(LFInput.Bindings[BindingIdx].Command == Command)
		{
			if(InStr(Locs(LFInput.Bindings[BindingIdx].Name), "xboxtypes") != -1 || InStr(Locs(LFInput.Bindings[BindingIdx].Name), "gamepad") != -1) //If This Bind Is For Gamepad
			{
				if(bGamepad) //If We Are Binding GamepadButton
				{
					RemoveBind(BindingIdx);
				}
			}
			else //If This Bind Not FOr GamePad
			{
				if(!bGamepad) //If We Are Binding Key
				{
					RemoveBind(BindingIdx);
				}
			}
		}
	}

	NewBind.Name = Key;
	NewBind.Command = Command;
	LFInput.Bindings.AddItem(NewBind);
	UpdateDataProvider();
	LFInput.SaveConfig();
}
function BindFieldClick(string clicked_item)
{
if(clicked_item == "attack_bind")
{
OpenBindKeyMovie("GBA_attack");
}
else if(clicked_item == "block_bind")
{
OpenBindKeyMovie("GBA_block");
}
else if(clicked_item == "menu_bind")
{
OpenBindKeyMovie("GBA_mainmenu");
}
}

function AttackClik()
{

OpenBindKeyMovie("GBA_attack");
UpdateDataProvider();
}

function BlockClik()
{

OpenBindKeyMovie("GBA_block");
}

function MenuClik()
{

OpenBindKeyMovie("GBA_mainmenu");
}

function Play_game()
{
ConsoleCommand("open base.udk");
}
function Quit_game()
{
ConsoleCommand("quit");
}

DefaultProperties
{
	bDisplayWithHudOff=true
	MovieInfo=SwfMovie'betamenu.betamenu'
	bEnableGammaCorrection = true;
	bCaptureInput=true;
	WidgetBindings(0) ={(WidgetName="master_v",WidgetClass = class'GFxClikWidget')}
	WidgetBindings(1) ={(WidgetName="res",WidgetClass = class'GFxClikWidget')}
	WidgetBindings(2) ={(WidgetName="bright_lvl",WidgetClass = class'GFxClikWidget')}
}
	
