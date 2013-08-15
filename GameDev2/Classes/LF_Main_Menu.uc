class LF_Main_Menu extends GFxMoviePlayer;
//z inputs
var LFPlayerInput LFInput;
// asset server ip 74.118.24.231
//password: Landfall!
//#960417
//================BINDING STUFF==================
var bool bCaptureForBind;
var name CapturedKey;
var array<UTUIDataProvider_KeyBinding> Binded, Blank;
//var int SelectedIndex;
var name CapturedBind;
var string DuplicateBindName;
var bool bDublicateBindDetected;
var GFxClikWidget M_Volume_Slider, music_volume_slider,sfx_volume_slider, res_men, bright_level, bloom_b;
var GFxClikWidget dialog_volume_slider, mouse_sense, text_quality, aa_level,blur_b;
var GFxClikWidget dx11, dy_shad, dy_light, s_decal, d_decal;
var GFxClikWidget ambient_o, distortion, vsync, directional_maps;
var GFxObject BindingMovie, BindKeyTF, DuplicateMovieTF, DuplicateTitleTF;
var GFxObject at_bind, bl_bind, menu_bind;
var GFxObject fwd_bind, bwd_bind, lft_bind, rght_bind;
var GFxObject jmp_bind, spnt_bind, use_bind;
var bool bConfirmChoice, bPendingUnbind;
var bool bloom_bool, blur_bool, dx11_bool, dy_shad_bool, dy_light_bool;
var bool s_decal_bool, d_decal_bool, ambient_o_bool, distortion_bool;
var bool vsync_bool, directional_maps_bool;
var string bind_at, bind_bl, bind_menu;
var string current_bind_cmd;
var LF_options_save_info options_save_info;
var LF_save_info save_info;
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

function LoadGame()
{
	local actor Player_Location_Actor;
    local GD2PlayerPawn LF_pawn;
	Player_Location_Actor = GetPC().Pawn;
    LF_pawn = GD2PlayerPawn(Player_Location_Actor);
	save_info = class'LF_save_info'.static.load_options();
	if(save_info == none)
	{
		save_info = new class'LF_save_info';
	}
	LF_Pawn.mission1 = save_info.mission_1;
	LF_Pawn.mission2a = save_info.mission_2;
	LF_Pawn.mission3 = save_info.mission_3;
	LF_Pawn.mission4 = save_info.mission_4;
	LF_Pawn.mission5 = save_info.mission_5;
	LF_Pawn.flashlightc = save_info.flashlight_state;
	GetPC().ConsoleCommand("open"@save_info.map_name$"?lf_load=x");
}
event bool WidgetInitialized(name WidgetName, name WidgetPath, GFxObject Widget)
{

	switch(WidgetName)
	{
		//slider
		case ('master_v'):
			M_Volume_Slider = GFxClikWidget(Widget);
			M_Volume_Slider.AddEventListener('CLIK_valueChange', volume_change);
			M_Volume_Slider.SetFloat("value", options_save_info.MasterVolume);
			break;
		case ('music_v'):
			music_volume_slider = GFxClikWidget(Widget);
			music_volume_slider.AddEventListener('CLIK_valueChange', music_volume_change);
			music_volume_slider.SetFloat("value", options_save_info.MusicVolume);
			break;
			
		case ('fx_v'):
			sfx_volume_slider = GFxClikWidget(Widget);
			sfx_volume_slider.AddEventListener('CLIK_valueChange', sfx_volume_change);
			sfx_volume_slider.SetFloat("value", options_save_info.FXVolume);
			break;
			
		case ('dialog_v'):
			dialog_volume_slider = GFxClikWidget(Widget);
			dialog_volume_slider.AddEventListener('CLIK_valueChange', dialog_volume_change);
			dialog_volume_slider.SetFloat("value", options_save_info.DialogVolume);
			break;
		case ('mouse_s'):
			mouse_sense = GFxClikWidget(Widget);
			mouse_sense.AddEventListener('CLIK_valueChange', sense_change);
			mouse_sense.SetFloat("value", options_save_info.CursorSensitivity);
			break;
		//list
		case ('text_q'):
			text_quality = GFxClikWidget(Widget);
			text_quality.AddEventListener('CLIK_valueChange', text_change);
			text_quality.SetInt("value", options_save_info.TextureLevel);
			break;
		case ('bright_l'):
			bright_level = GFxClikWidget(Widget);
			bright_level.AddEventListener('CLIK_valueChange', lf_change_bright);
			bright_level.SetFloat("value", options_save_info.Brightness);
			break;
		//dropdown
		case ('res'):
			res_men = GFxClikWidget(Widget);
			lf_change_res();
			res_men.SetFloat("selectedIndex", FindRes(options_save_info.Resolution));
			break;
		case ('aa_lvl'):
			aa_level = GFxClikWidget(Widget);
			lf_set_aa_list();
			aa_level.SetFloat("selectedIndex",FindAA(options_save_info.AALevel));
			break;
		//check box
		case ('Bloom'):
			bloom_b = GFxClikWidget(Widget);
			bloom_b.SetBool("selected",bloom_bool);
			SetMyCheckBox(bloom_b.GetBool("selected"));
			break;
		case('blur'):
			blur_b = GFxClikWidget(Widget);
			blur_b.SetBool("selected",blur_bool);
			SetMyCheckBox(blur_b.GetBool("selected"));
			break;
		case('dx11'):
			dx11 = GFxClikWidget(Widget);
			dx11.SetBool("selected",dx11_bool);
			SetMyCheckBox(dx11.GetBool("selected"));
			break;
		case('d_shad'):
			dy_shad = GFxClikWidget(Widget);
			dy_shad.SetBool("selected",dy_shad_bool);
			SetMyCheckBox(dy_shad.GetBool("selected"));
			break;
		case('d_light'):
			dy_light = GFxClikWidget(Widget);
			dy_light.SetBool("selected",dy_light_bool);
			SetMyCheckBox(dy_light.GetBool("selected"));
			break;
		case('s_decal'):
			s_decal = GFxClikWidget(Widget);
			s_decal.SetBool("selected",s_decal_bool);
			SetMyCheckBox(s_decal.GetBool("selected"));
			break;
		case('d_decal'):
			d_decal = GFxClikWidget(Widget);
			d_decal.SetBool("selected",d_decal_bool);
			SetMyCheckBox(d_decal.GetBool("selected"));
			break;
		case('a_occl'):
			ambient_o = GFxClikWidget(Widget);
			ambient_o.SetBool("selected",ambient_o_bool);
			SetMyCheckBox(ambient_o.GetBool("selected"));
			break;
		case('dist'):
			distortion = GFxClikWidget(Widget);
			distortion.SetBool("selected",distortion_bool);
			SetMyCheckBox(distortion.GetBool("selected"));
			break;
		case('vsync'):
			vsync = GFxClikWidget(Widget);
			vsync.SetBool("selected",vsync_bool);
			SetMyCheckBox(vsync.GetBool("selected"));
			break;
		case('d_light_maps'):
			directional_maps = GFxClikWidget(Widget);
			directional_maps.SetBool("selected",directional_maps_bool);
			SetMyCheckBox(directional_maps.GetBool("selected"));
			break;
		default:
			break;
	}
	return True;
}
function apply()
{
	local float x;
	//local string anti_alias;
	lf_check_aa(aa_level.GetFloat("selectedIndex"));
	options_save_info.AAIndex = aa_level.GetFloat("selectedIndex");
	x = mouse_sense.GetFloat("value");
	GetPC().ConsoleCommand("SetRes"@lf_check_res(res_men.GetFloat("selectedIndex")));
	GetPC().ConsoleCommand("Scale Set Bloom "$bloom_b.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set MotionBlur "$blur_b.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set MaxAnisotropy "$options_save_info.TextureLevel);
	GetPC().ConsoleCommand("setSensitivity"@x);
	GetPC().ConsoleCommand("Scale Set AllowD3D11 "$dx11.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set DynamicShadows "$dy_shad.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set DynamicLights "$dy_light.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set StaticDecals "$s_decal.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set DynamicDecals "$d_decal.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set AmbientOcclusion "$ambient_o.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set Distortion "$distortion.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set UseVSync "$vsync.GetBool("selected"));
	GetPC().ConsoleCommand("Scale Set DirectionalLightMaps "$directional_maps.GetBool("selected"));
	options_save_info.save_options();
	refresh_video();
}
function refresh_video()
{	
	bloom_b.GetBool("selected");
	blur_b.GetBool("selected");
	dx11.GetBool("selected");
	dy_shad.GetBool("selected");
	dy_light.GetBool("selected");
	s_decal.GetBool("selected");
	d_decal.GetBool("selected");
	ambient_o.GetBool("selected");
	distortion.GetBool("selected");
	vsync.GetBool("selected");
	directional_maps.GetBool("selected");
	//`log(bloom_bool);
}
function SetMyCheckBox(bool b)
{
 ActionScriptVoid("SetMyCheckBox");
}
function load_provider_array_brightness()
{
	local array<String> bright_levels;
	local int i;
	
	for(i = 0; i <10; i++)
	{
		bright_levels.AddItem(string(i));
	}
	SetVariableStringArray("_root.bright_lvl.dataProvider",0,bright_levels);
}
function int FindRes(string reso)
{
	local array<string> resol;
	getVariableStringArray("_root.res.dataProvider",0,resol);
	return resol.Find(reso);
}
function int FindAA(string a_a)
{	
	local array<String> aa;
	getVariableStringArray("_root.aa_lvl.dataProvider",0,aa);
	return aa.Find(a_a);
}
//going to read dataprovider and return string of resolution
function string lf_check_res(int index)
{
	local array<string> res_c;
	
	getVariableStringArray("_root.res.dataProvider",0,res_c);
	if(index < res_c.length)
	{
		return res_c[index];
	}
	else
	{
		if(res_c.length > 0)
		{
			return res_c[0];
		}
		//failsafe
		else
		{
			return "1280x720";
		}
	}
}
function lf_check_aa(int index)
{
   local PostProcessChain Chain;
   local PostProcessEffect Effect;

   Chain = GetPC().WorldInfo.WorldPostProcessChain;
    if (Chain != None && index < 6)
    {
        foreach Chain.Effects(Effect)
        {
            if (UberPostProcessEffect(Effect) != None)
            {
                switch(index)
                {
                    case 0:			
						 UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_Off;
                      break;
                    case 1:
					 UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA1;
                 
                        break;
                    case 2:
					 UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA2;
                       // UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA2;
                        break;
                    case 3:
					 UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA3;
                       // UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA3;
                        break;
                    case 4:
					 UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA4;
                       // UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA4;
                        break;
                    case 5:
					 UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_FXAA5;           
                    //case 6:
					 //UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_MLAA;
                       // UberPostProcessEffect(Effect).PostProcessAAType = PostProcessAA_MLAA;
                        break;
                }
			}
		}
	}    

}
function lf_change_res()
{
	local array<String> res_levels;
	local string res_string;
	local int i;
	
	res_string = GetPC().ConsoleCommand("DUMPAVAILABLERESOLUTIONS", false);
	ParseStringIntoArray(res_string,res_levels, "\n", true);
	
	for(i = res_levels.Length - 1; i>0; i--)
	{
		if (res_levels[i] == res_levels[i-1])
		{
			res_levels.Remove(i,1);
		}
	
	}
	SetVariableStringArray("_root.res.dataProvider",0,res_levels);
}
function lf_set_aa_list()
{
	local array<String> aa_levels;
	local string aa_string;
	
	aa_string = "Off\nx0\nx2\nx4\nx8\nx16\n";
	ParseStringIntoArray(aa_string,aa_levels, "\n", true);
	SetVariableStringArray("_root.aa_lvl.dataProvider",0,aa_levels);
}
function lf_change_bright(GFxClikWidget.EventData ev)
{
	options_save_info.Brightness = bright_level.GetFloat("value");
	//`log(bright_level.GetFloat("selectedIndex"));
	GetPC().ConsoleCommand("gamma "$options_save_info.Brightness$"\n");
	options_save_info.save_options();
}
function volume_change(GFxClikWidget.EventData ev)
{
	GetPC().SetAudioGroupVolume('Master',M_Volume_Slider.GetFloat("value"));
	options_save_info.MasterVolume = M_Volume_Slider.GetFloat("value");
	options_save_info.save_options();
}
function music_volume_change(GFxClikWidget.EventData ev)
{
	GetPC().SetAudioGroupVolume('Music',music_volume_slider.GetFloat("value"));
	options_save_info.MusicVolume = music_volume_slider.GetFloat("value");
	options_save_info.save_options();

}
function sfx_volume_change(GFxClikWidget.EventData ev)
{
	GetPC().SetAudioGroupVolume('SFX',sfx_volume_slider.GetFloat("value"));
	options_save_info.FXVolume = sfx_volume_slider.GetFloat("value");
	options_save_info.save_options();

}
function dialog_volume_change(GFxClikWidget.EventData ev)
{
	GetPC().SetAudioGroupVolume('Dialog',dialog_volume_slider.GetFloat("value"));
	options_save_info.DialogVolume = dialog_volume_slider.GetFloat("value");
	options_save_info.save_options();
}
function sense_change(GFxClikWidget.EventData ev)
{
	//GetPC().ConsoleCommand("setSensitivity "$mouse_sense.GetFloat("value"));
	options_save_info.CursorSensitivity = mouse_sense.GetFloat("value");
	`log(mouse_sense.GetFloat("value"));
	options_save_info.save_options();
}
function text_change(GFxClikWidget.EventData ev)
{
	//GetPC().ConsoleCommand("setSensitivity "$mouse_sense.GetFloat("value"));
	options_save_info.TextureLevel = text_quality.GetInt("value");
	if(options_save_info.TextureLevel > 8)
	{
		options_save_info.TextureLevel = 16;
	}
	else if(options_save_info.TextureLevel <= 8 && options_save_info.TextureLevel>4)
	{
		options_save_info.TextureLevel = 8;
	}
	else if(options_save_info.TextureLevel <= 4 && options_save_info.TextureLevel>2)
	{
		options_save_info.TextureLevel = 4;
	}
	else if(options_save_info.TextureLevel <= 2 && options_save_info.TextureLevel>0)
	{
		options_save_info.TextureLevel = 2;
	}
	`log(options_save_info.TextureLevel);
	options_save_info.save_options();
}
function ControlOptionsOpened()
{
	//`log("stuff happend");
	BindingMovie = GetVariableObject("_root.dupeMC");
	UpdateDataProvider();
	at_bind = GetVariableObject("_root.attack_bind");
	bl_bind = GetVariableObject("_root.block_bind");
	menu_bind = GetVariableObject("_root.menu_bind");
	fwd_bind = GetVariableObject("_root.fwdd_bind");
	bwd_bind = GetVariableObject("_root.bwdd_bind");
	lft_bind = GetVariableObject("_root.lftt_bind");
	rght_bind = GetVariableObject("_root.rghtt_bind");
	spnt_bind = GetVariableObject("_root.spntt_bind");
	jmp_bind = GetVariableObject("_root.jmrp_bind");
	use_bind = GetVariableObject("_root.usee_bind");
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
	bl_bind = GetVariableObject("_root.block_bind");
	menu_bind = GetVariableObject("_root.menu_bind");
	fwd_bind = GetVariableObject("_root.fwdd_bind");
	bwd_bind = GetVariableObject("_root.bwdd_bind");
	lft_bind = GetVariableObject("_root.lftt_bind");
	rght_bind = GetVariableObject("_root.rghtt_bind");
	spnt_bind = GetVariableObject("_root.spntt_bind");
	jmp_bind = GetVariableObject("_root.jmpp_bind");
	use_bind = GetVariableObject("_root.usee_bind");
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
		if(Binded[i].Command == "GBA_attack" || Binded[i].Command == "GBA_block" || Binded[i].Command == "GBA_mainmenu" 
		|| Binded[i].Command == "GBA_MoveForward" || Binded[i].Command == "GBA_Backward" || Binded[i].Command == "GBA_StrafeLeft" 
		|| Binded[i].Command == "GBA_StrafeRight" || Binded[i].Command == "GBA_sprinting" || Binded[i].Command == "GBA_Jump" 
		|| Binded[i].Command == "GBA_Use" )
		{
		//loops through the binded list and finds the bind value associated to the name
			for(BindingIdx=0; BindingIdx<LFInput.Bindings.Length; BindingIdx++)
			{
				if(LFInput.Bindings[BindingIdx].Command == Binded[i].Command)
				{
						GBA_BindValue = String(LFInput.Bindings[BindingIdx].Name);
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
								at_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								at_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								at_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								at_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								at_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								at_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								at_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								at_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								at_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								at_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								at_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								at_bind.SetText("Right Alt");
							}
							else
							{
							at_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_block")
						{
								if(GBA_BindValue == "F1")
							{
								bl_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								bl_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								bl_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								bl_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								bl_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								bl_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								bl_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								bl_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								bl_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								bl_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								bl_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								bl_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								bl_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								bl_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								bl_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								bl_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								bl_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								bl_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								bl_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								bl_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								bl_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								bl_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								bl_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								bl_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								bl_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								bl_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								bl_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								bl_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								bl_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								bl_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								bl_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								bl_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								bl_bind.SetText("Right Alt");
							}
							else
							{
							bl_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_mainmenu")
						{
								if(GBA_BindValue == "F1")
							{
								menu_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								menu_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								menu_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								menu_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								menu_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								menu_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								menu_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								menu_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								menu_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								menu_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								menu_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								menu_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								menu_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								menu_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								menu_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								menu_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								menu_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								menu_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								menu_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								menu_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								menu_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								menu_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								menu_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								menu_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								menu_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								menu_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								menu_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								menu_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								menu_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								menu_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								menu_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								menu_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								menu_bind.SetText("Right Alt");
							}				
							else
							{
							menu_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_MoveForward")
						{
							if(GBA_BindValue == "F1")
							{
								fwd_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								fwd_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								fwd_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								fwd_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								fwd_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								fwd_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								fwd_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								fwd_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								fwd_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								fwd_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								fwd_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								fwd_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								fwd_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								fwd_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								fwd_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								fwd_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								fwd_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								fwd_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								fwd_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								fwd_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								fwd_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								fwd_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								fwd_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								fwd_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								fwd_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								fwd_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								fwd_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								fwd_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								fwd_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								fwd_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								fwd_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								fwd_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								fwd_bind.SetText("Right Alt");
							}
							else
							{
							fwd_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_Backward")
						{
							if(GBA_BindValue == "F1")
							{
								bwd_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								bwd_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								bwd_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								bwd_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								bwd_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								bwd_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								bwd_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								bwd_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								bwd_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								bwd_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								bwd_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								bwd_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								bwd_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								bwd_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								bwd_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								bwd_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								bwd_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								bwd_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								bwd_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								bwd_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								bwd_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								bwd_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								bwd_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								bwd_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								bwd_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								bwd_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								bwd_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								bwd_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								bwd_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								bwd_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								bwd_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								bwd_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								bwd_bind.SetText("Right Alt");
							}
							else
							{
							bwd_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_StrafeLeft")
						{
							if(GBA_BindValue == "F1")
							{
								lft_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								lft_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								lft_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								lft_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								lft_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								lft_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								lft_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								lft_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								lft_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								lft_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								lft_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								lft_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								lft_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								lft_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								lft_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								lft_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								lft_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								lft_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								lft_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								lft_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								lft_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								lft_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								lft_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								lft_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								lft_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								lft_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								lft_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								lft_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								lft_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								lft_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								lft_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								lft_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								lft_bind.SetText("Right Alt");
							}
							else
							{
							lft_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_StrafeRight")
						{
							if(GBA_BindValue == "F1")
							{
								rght_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								rght_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								rght_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								rght_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								rght_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								rght_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								rght_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								rght_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								rght_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								rght_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								rght_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								rght_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								rght_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								rght_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								rght_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								rght_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								rght_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								rght_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								rght_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								rght_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								rght_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								rght_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								rght_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								rght_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								rght_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								rght_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								rght_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								rght_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								rght_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								rght_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								rght_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								rght_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								rght_bind.SetText("Right Alt");
							}
							else
							{
								rght_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_sprinting")
						{
							if(GBA_BindValue == "F1")
							{
								spnt_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								spnt_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								spnt_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								spnt_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								spnt_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								spnt_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								spnt_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								spnt_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								spnt_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								spnt_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								spnt_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								spnt_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								spnt_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								spnt_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								spnt_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								spnt_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								spnt_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								spnt_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								spnt_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								spnt_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								spnt_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								spnt_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								spnt_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								spnt_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								spnt_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								spnt_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								spnt_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								spnt_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								spnt_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								spnt_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								spnt_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								spnt_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								spnt_bind.SetText("Right Alt");
							}
							else
							{
							spnt_bind.SetText(GBA_BindValue);
							}
						}
						
						if(Binded[i].Command == "GBA_Jump")
						{
							if(GBA_BindValue == "F1")
							{
								jmp_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								jmp_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								jmp_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								jmp_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								jmp_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								jmp_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								jmp_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								jmp_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								jmp_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								jmp_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								jmp_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								jmp_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								jmp_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								jmp_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								jmp_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								jmp_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								jmp_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								jmp_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								jmp_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								jmp_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								jmp_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								jmp_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								jmp_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								jmp_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								jmp_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								jmp_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								jmp_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								jmp_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								jmp_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								jmp_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								jmp_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								jmp_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								jmp_bind.SetText("Right Alt");
							}
							else
							{
								jmp_bind.SetText(GBA_BindValue);
							}
						}
						if(Binded[i].Command == "GBA_Use")
						{
							if(GBA_BindValue == "F1")
							{
								use_bind.SetText("F One");
							}
							else if(GBA_BindValue == "F2")
							{
								use_bind.SetText("F Two");
							}
							else if(GBA_BindValue == "F3")
							{
								use_bind.SetText("F Three");
							}
							else if(GBA_BindValue == "F4")
							{
								use_bind.SetText("F Four");
							}
							else if(GBA_BindValue == "F5")
							{
								use_bind.SetText("F Five");
							}
							else if(GBA_BindValue == "F6")
							{
								use_bind.SetText("F Six");
							}
							else if(GBA_BindValue == "F7")
							{
								use_bind.SetText("F Seven");
							}
							else if(GBA_BindValue == "F8")
							{
								use_bind.SetText("F Eight");
							}
							else if(GBA_BindValue == "F9")
							{
								use_bind.SetText("F Nine");
							}
							else if(GBA_BindValue == "F10")
							{
								use_bind.SetText("F Ten");
							}
							else if(GBA_BindValue == "F12")
							{
								use_bind.SetText("F Twelve");
							}
							else if(GBA_BindValue == "one")
							{
								use_bind.SetText("One");
							}
							else if(GBA_BindValue == "two")
							{
								use_bind.SetText("Two");
							}
							else if(GBA_BindValue == "three")
							{
								use_bind.SetText("Three");
							}
							else if(GBA_BindValue == "four")
							{
								use_bind.SetText("Four");
							}
							else if(GBA_BindValue == "five")
							{
								use_bind.SetText("Five");
							}
							else if(GBA_BindValue == "six")
							{
								use_bind.SetText("Six");
							}
							else if(GBA_BindValue == "seven")
							{
								use_bind.SetText("Seven");
							}
							else if(GBA_BindValue == "eight")
							{
								use_bind.SetText("Eight");
							}
							else if(GBA_BindValue == "nine")
							{
								use_bind.SetText("Nine");
							}
							else if(GBA_BindValue == "zero")
							{
								use_bind.SetText("Zero");
							}
							else if(GBA_BindValue == "LeftMouseButton")
							{
								use_bind.SetText("Left Mouse");
							}
							else if(GBA_BindValue == "RightMouseButton")
							{
								use_bind.SetText("Right Mouse");
							}
							else if(GBA_BindValue == "SpaceBar")
							{
								use_bind.SetText("Space Bar");
							}
							else if(GBA_BindValue == "LeftControl")
							{
								use_bind.SetText("Left Control");
							}
							else if(GBA_BindValue == "RightControl")
							{
								use_bind.SetText("Right Control");
							}
							else if(GBA_BindValue == "LeftBracket")
							{
								use_bind.SetText("Left Bracket");
							}
							else if(GBA_BindValue == "RightBracket")
							{
								use_bind.SetText("Right Bracket");
							}
							else if(GBA_BindValue == "CapsLock")
							{
								use_bind.SetText("Caps Lock");
							}
							else if(GBA_BindValue == "LeftShift")
							{
								use_bind.SetText("Left Shift");
							}
							else if(GBA_BindValue == "RightShift")
							{
								use_bind.SetText("Right Shift");
							}
							else if(GBA_BindValue == "LeftAlt")
							{
								use_bind.SetText("Left Alt");
							}
							else if(GBA_BindValue == "RightAlt")
							{
								use_bind.SetText("Right Alt");
							}
							else
							{
								use_bind.SetText(GBA_BindValue);
							}
						}
				}
			}
		}
	}
}
function OpenBindKeyMovie(string bind_name)
{

	current_bind_cmd = bind_name;
	BindingMovie.GotoAndStopI(2);
	BindKeyTF = GetVariableObject("_root.dupeMC.dupeTF");
	if(bind_name == "GBA_attack")
	{
		bind_name = "Attack";
	}
	else if(bind_name == "GBA_block")
	{
		bind_name = "Block";
	}
	else if(bind_name == "GBA_mainmenu")
	{
		bind_name = "Main Menu";
	}
	else if(bind_name == "GBA_MoveForward")
	{
		bind_name = "Move Forward";
	}
	else if(bind_name == "GBA_Backward")
	{
		bind_name = "Move Backward";
	}
	else if(bind_name == "GBA_StrafeLeft")
	{
		bind_name = "Move Left";
	}
	else if(bind_name == "GBA_StrafeRight")
	{
		bind_name = "Move Right";
	}
	else if(bind_name == "GBA_sprinting")
	{
		bind_name = "Sprint";
	}
	else if(bind_name == "GBA_Jump")
	{
		bind_name = "Jump";
	}
	else if(bind_name == "GBA_Use")
	{
		bind_name = "Use";
	}
	BindKeyTF.SetText("Press The Key\n you want to use for\n" $ bind_name);
	bCaptureForBind=true;
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
				//`log(LFInput.Bindings[BindingIdx].Command@Binded[i].Command);
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
		if(string(BindKeyName) == "F1" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F One Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F2" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Two Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F3" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Three Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F4" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Four Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F5" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Five Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F6" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Six Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F7" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Seven Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F8" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Eight Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F9" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Nine Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F10" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Ten Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F12" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("F Twelve Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "CapsLock" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Caps Lock Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftBracket" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Left Bracket Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightBracket" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Right Bracket Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftShift" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Left Shift Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightShift" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Right Shift Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftAlt" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Left Alt Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightAlt" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Right Alt Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftControl" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Left Control Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightControl" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Right Control Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F1" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F One Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F2" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Two Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F3" && BindFriendlyName == "StrafeRoght")
		{
			BindKeyTF.SetText("F Three Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F4" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Four Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F5" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Five Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F6" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Six Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F7" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Seven Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F8" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Eight Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F9" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Nine Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F10" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Ten Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F12" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("F Twelve Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "CapsLock" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Caps Lock Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftBracket" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Left Bracket Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightBracket" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Right Bracket Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftShift" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Left Shift Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightShift" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Right Shift Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftAlt" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Left Alt Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightAlt" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Right Alt Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftControl" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Left Control Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightControl" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Right Control Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F1" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F One Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F2" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Two Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F3" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Three Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F4" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Four Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F5" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Five Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F6" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Six Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F7" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Seven Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F8" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Eight Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F9" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Nine Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F10" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Ten Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F12" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("F Twelve Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "CapsLock" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Caps Lock Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftBracket" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Left Bracket Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightBracket" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Right Bracket Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftShift" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Left Shift Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightShift" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Right Shift Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftAlt" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Left Alt Is Already\n Bound To\n Move Foward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightAlt" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Right Alt Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftControl" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Left Control Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightControl" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Right Control Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F1" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F One Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F2" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Two Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F3" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Three Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F4" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Four Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F5" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Five Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F6" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Six Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F7" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Seven Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F8" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Eight Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F9" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Nine Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F10" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Ten Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F12" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("F Twelve Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "CapsLock" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Caps Lock Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftBracket" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Left Bracket Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightBracket" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Right Bracket Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftShift" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Left Shift Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightShift" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Right Shift Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftAlt" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Left Alt Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightAlt" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Right Alt Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftControl" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Left Control Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightControl" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Right Control Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F1" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F One Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F2" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Two Is Already\n Bound To\n Move Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F3" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Three Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F4" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Four Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F5" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Five Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F6" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Six Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F7" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Seven Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F8" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Eight Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F9" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Nine Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F10" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Ten Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F12" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("F Twelve Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "CapsLock" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Caps Lock Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftBracket" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Left Bracket Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightBracket" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Right Bracket Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftShift" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Left Shift Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightShift" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Right Shift Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftAlt" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Left Alt Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightAlt" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Right Alt Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftControl" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Left Control Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightControl" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Right Control Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F1")
		{
			BindKeyTF.SetText("F One Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F2")
		{
			BindKeyTF.SetText("F Two Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F3")
		{
			BindKeyTF.SetText("F Three Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F4")
		{
			BindKeyTF.SetText("F Four Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F5")
		{
			BindKeyTF.SetText("F Five Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F6")
		{
			BindKeyTF.SetText("F Six Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F7")
		{
			BindKeyTF.SetText("F Seven Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F8")
		{
			BindKeyTF.SetText("F Eight Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F9")
		{
			BindKeyTF.SetText("F Nine Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F10")
		{
			BindKeyTF.SetText("F Ten Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "F12")
		{
			BindKeyTF.SetText("F Twelve Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "CapsLock")
		{
			BindKeyTF.SetText("Caps Lock Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftBracket")
		{
			BindKeyTF.SetText("Left Bracket Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightBracket")
		{
			BindKeyTF.SetText("Right Bracket Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftShift")
		{
			BindKeyTF.SetText("Left Shift Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightShift")
		{
			BindKeyTF.SetText("Right Shift Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftAlt")
		{
			BindKeyTF.SetText("Left Alt Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightAlt")
		{
			BindKeyTF.SetText("Right Alt Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftControl")
		{
			BindKeyTF.SetText("Left Control Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightControl")
		{
			BindKeyTF.SetText("Right Control Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftMouseButton")
		{
			BindKeyTF.SetText("Left Mouse Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightMouseButton")
		{
			BindKeyTF.SetText("Right Mouse Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "SpaceBar")
		{
			BindKeyTF.SetText("Space Bar Is Already\n Bound To\n"$BindFriendlyName$"\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "SpaceBar" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Space Bar Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "SpaceBar" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Space Bar Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "SpaceBar" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Space Bar Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "SpaceBar" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("SpaceBar Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "SpaceBar" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Space Bar Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftMouseButton" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Left Mouse Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightMouseButton" && BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText("Right Mouse Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftMouseButton" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Left Mouse Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightMouseButton" && BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText("Right Mouse Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftMouseButton" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Left Mouse Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightMouseButton" && BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText("Right Mouse Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftMouseButton" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Left Mouse Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightMouseButton" && BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText("Right Mouse Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "LeftMouseButton" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Left Mouse Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(string(BindKeyName) == "RightMouseButton" && BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText("Right Mouse Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else if(BindFriendlyName == "MoveForward")
		{
			BindKeyTF.SetText(BindKeyName$" Is Already\n Bound To\n Move Forward\n Press any Key to \nContinue");
		}
		else if(BindFriendlyName == "MoveBackward")
		{
			BindKeyTF.SetText(BindKeyName$" Is Already\n Bound To\n Move Backward\n Press any Key to \nContinue");
		}
		else if(BindFriendlyName == "StrafeLeft")
		{
			BindKeyTF.SetText(BindKeyName$" Is Already\n Bound To\n Move Left\n Press any Key to \nContinue");
		}
		else if(BindFriendlyName == "StrafeRight")
		{
			BindKeyTF.SetText(BindKeyName$" Is Already\n Bound To\n Move Right\n Press any Key to \nContinue");
		}
		else if(BindFriendlyName == "MainMenu")
		{
			BindKeyTF.SetText(BindKeyName$" Is Already\n Bound To\n Main Menu\n Press any Key to \nContinue");
		}
		else
		{
			BindKeyTF.SetText(BindKeyName$" Is Already\n Bound To\n "$BindFriendlyName$" Press any \n Key to \nContinue");
		}
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
	else if(clicked_item == "fwdd_bind")
	{
	OpenBindKeyMovie("GBA_MoveForward");
	}
	else if(clicked_item == "bwdd_bind")
	{
	OpenBindKeyMovie("GBA_Backward");
	}
	else if(clicked_item == "lftt_bind")
	{
	OpenBindKeyMovie("GBA_StrafeLeft");
	}
	else if(clicked_item == "rghtt_bind")
	{
	OpenBindKeyMovie("GBA_StrafeRight");
	}
	else if(clicked_item == "spntt_bind")
	{
	OpenBindKeyMovie("GBA_sprinting");
	}
	else if(clicked_item == "jmpp_bind")
	{
	OpenBindKeyMovie("GBA_Jump");
	}
	else if(clicked_item == "usee_bind")
	{
	OpenBindKeyMovie("GBA_Use");
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
UpdateDataProvider();
}

function MenuClik()
{
OpenBindKeyMovie("GBA_mainmenu");
UpdateDataProvider();
}
function ForwardClik()
{
OpenBindKeyMovie("GBA_MoveForward");
UpdateDataProvider();
}
function BackwardClik()
{
OpenBindKeyMovie("GBA_Backward");
UpdateDataProvider();
}
function LeftClik()
{
OpenBindKeyMovie("GBA_StrafeLeft");
UpdateDataProvider();
}
function RightClik()
{
OpenBindKeyMovie("GBA_StrafeRight");
UpdateDataProvider();
}
function SprintClik()
{
OpenBindKeyMovie("GBA_sprinting");
UpdateDataProvider();
}
function JumpClik()
{
OpenBindKeyMovie("GBA_Jump");
UpdateDataProvider();
}
function UseClik()
{
OpenBindKeyMovie("GBA_Use");
UpdateDataProvider();
}
function Play_game()
{
ConsoleCommand("open base");
}
function Quit_game()
{
ConsoleCommand("quit");
}

DefaultProperties
{
	bDisplayWithHudOff=true
	MovieInfo=SwfMovie'betamenu.betamenu'
	bCaptureInput=true;
	WidgetBindings(0) ={(WidgetName="master_v",WidgetClass = class'GFxClikWidget')}
	WidgetBindings(1) ={(WidgetName="res",WidgetClass = class'GFxClikWidget')}
	WidgetBindings(2) ={(WidgetName="bright_l",WidgetClass = class'GFxClikWidget')}
	WidgetBindings(3)={(WidgetName="Bloom",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(4)={(WidgetName="music_v",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(5)={(WidgetName="fx_v",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(6)={(WidgetName="dialog_v",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(7)={(WidgetName="mouse_s",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(8)={(WidgetName="text_q",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(9)={(WidgetName="aa_lvl",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(10)={(WidgetName="blur",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(11)={(WidgetName="dx11",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(12)={(WidgetName="d_shad",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(13)={(WidgetName="d_light",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(14)={(WidgetName="s_decal",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(15)={(WidgetName="d_decal",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(16)={(WidgetName="a_occl",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(17)={(WidgetName="dist",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(18)={(WidgetName="vsync",WidgetClass=class'GFxClikWidget')}
	WidgetBindings(19)={(WidgetName="d_light_maps",WidgetClass=class'GFxClikWidget')}
}
	
