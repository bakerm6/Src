class LF_Main_Menu extends GFxMoviePlayer;
//z inputs
var LFPlayerInput LFInput;

//================BINDING STUFF==================
var bool bCaptureForBind;
var name CapturedKey;
var array<LFUIDataProvider_KeyBinds> Binded, Blank;
var int SelectedIndex;
var name CapturedBind;
var string DuplicateBindName;
var int DuplicateBindIndex;
var bool bDublicateBindDetected;
var GFxClikWidget ListMC;
var GFxObject ListDataProvider, BindingMovie, BindKeyTF, DuplicateMovieTF, DuplicateTitleTF;
var bool bConfirmChoice, bPendingUnbind;
//==================================================


function Init(optional LocalPlayer LocPlay)
{
	Start();
	Advance(0.f);
	SetViewScaleMode(SM_ExactFit);
}

event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{
	switch(WidgetName)
	{
		case ('bindList'):
			LFInput = LFPlayerInput(GetPC().PlayerInput);
			ListMC = GFxClikWidget(GetVariableObject("_root.bindings.bindList"));
			UpdateDataProvider();
			ListMC.AddEventListener('CLIK_itemPress', OnListItemPressed);
			break;
		default:
			break;
	}
	return True;
}

function ControlOptionsOpened()
{
	BindingMovie = GetVariableObject("_root.bindings.dupeMC");
}
//updates list in flash with binding info
function UpdateDataProvider()
{
	local int i, BindingIdx;
	local GFxObject TempObj;
	local GFxObject GFxProvider;
	local String GBA_BindValue;
	//contains key-bind information
	local array<UDKUIResourceDataProvider> ProviderList;

	if(LFInput==none)
		return;
	//blank is an empty object thing
	Binded=Blank;
	//loads keybinds into a list(array)
	class'UDKUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'LFUIDataProvider_KeyBinds', ProviderList);
	for(i=0; i<ProviderList.Length; i++)
	{  
		//binded is a array of LFUIProvideer objects
		Binded.InsertItem(0, LFUIDataProvider_KeyBinds(ProviderList[i]));
	}
	//a GFxObject array with each object having a value
	//GFXARRAY
	GFxProvider = CreateArray();

	for(i=0; i<Binded.Length; i++)
	{
		GBA_BindValue = "";
		TempObj = CreateObject("Object");
		//loops through the binded list and finds the bind value associated to the name
		for(BindingIdx=0; BindingIdx<LFInput.Bindings.Length; BindingIdx++)
		{
			if(LFInput.Bindings[BindingIdx].Command == Binded[i].Command)
			{
					GBA_BindValue = String(LFInput.Bindings[BindingIdx].Name);
					TempObj.SetString("label", GBA_BindValue);
				
			}
		}
		GFxProvider.SetElementObject(i, TempObj);
	}
	ListMC.SetObject("dataProvider", GFxProvider);
	ListDataProvider=ListMC.GetObject("dataProvider");
}
//click item in flash list
function OnListItemPressed(GFxClikWidget.EventData ev)
{
	OpenBindKeyMovie(ev.index);
}

function OpenBindKeyMovie(int Index)
{
	SelectedIndex = Index;
	ListMC.SetBool("disabled", true);
	BindingMovie.GotoAndPlayI(2);
	BindKeyTF = GetVariableObject("_root.container.optionsMain.container.bindings.dupeMC.dupeTF");
	BindKeyTF.SetText("Press The Key you want to use for\n" $ GetBindName(Index));
	bCaptureForBind=true;
}
// returns friendly name
function string GetBindName(int FindIndex)
{
	return Binded[FindIndex].FriendlyName;
}
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
		if(ButtonName=='Enter' || ButtonName=='XboxTypeS_A')
		{
			bConfirmChoice=false;
			DuplicateMovieYes();
		}
		else if(ButtonName=='Escape' || ButtonName=='XboxTypeS_B')
		{
			bConfirmChoice=false;
			DuplicateMovieNo();
		}
	}
	return false;
}

function ReturnToList()
{
	BindingMovie.GotoAndStopI(1);
	ListMC.SetBool("disabled", false);
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
		if(CapturedKey==BindingName)
		{
			Command=LFInput.Bindings[BindingIdx].Command;
			if(Command!=Binded[SelectedIndex].Command)
			{
				for(i=0; i<Binded.Length; i++)
				{
					if(LFInput.Bindings[BindingIdx].Command == Binded[i].Command)
					{
						DuplicateBindName = Binded[i].FriendlyName;
						DuplicateBindIndex = BindingIdx;
						return true;
					}
				}
			}
			if(LFInput.Bindings[BindingIdx].Command == Binded[SelectedIndex].Command)
			{
				DuplicateBindIndex = BindingIdx;
				DuplicateBindName = String(LFInput.Bindings[BindingIdx].Name);
				return true;
			}
		}
	}
	return false;
}

function OpenDuplicateBindMovie(name BindKeyName, string BindFriendlyName)
{
	BindingMovie.GotoAndPlayI(3);
	bConfirmChoice=true;
	DuplicateTitleTF = GetVariableObject("_root.container.optionsMain.container.bindings.dupeMC.dupetitle");
	DuplicateMovieTF = GetVariableObject("_root.container.optionsMain.container.bindings.dupeMC.dupeTF");
	if(string(BindKeyName) != BindFriendlyName)
	{
		DuplicateTitleTF.SetText("Duplicate Keybind");
		DuplicateMovieTF.SetText(BindKeyName$" Is Already Bound To "$BindFriendlyName$". Are You Sure You Wish To Continue?");
	}
	else
	{
		DuplicateTitleTF.SetText("Unbind Key");
		DuplicateMovieTF.SetText("Do YOu Wish To Unbind "$BindFriendlyName$"?");
		bPendingUnbind=true;
	}
}

function DuplicateMovieYes()
{
	ReturnToList();
	if(bPendingUnbind)
	{
		bPendingUnbind=false;
		RemoveBind(DuplicateBindIndex);
	}
	else
	{
		RemoveBind(DuplicateBindIndex);
		SetNewBind(CapturedBind, Binded[SelectedIndex].Command);
	}
}

function DuplicateMovieNo()
{
	ReturnToList();
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
		if(LFInput.Bindings[BindingIdx].Command == Binded[SelectedIndex].Command)
		{
			if(CapturedKey == LFInput.Bindings[BindingIdx].Name)
			{
				RemoveBind(BindingIdx);
				return;
			}
		}
	}
	SetNewBind(CapturedKey, Binded[SelectedIndex].Command);
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

DefaultProperties
{
	bDisplayWithHudOff=true
	MovieInfo=SwfMovie'betamenu.betamenu'
	bEnableGammaCorrection = true;
	bCaptureInput=true;

	WidgetBindings(0)={(WidgetName="bindList",WidgetClass=class'GFxClikWidget')}
	}
	
