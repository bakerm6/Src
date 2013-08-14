class LF_options_save_info extends Object;

var float Brightness;
var int TextureLevel,FOVLevel;
var float MasterVolume, MusicVolume, FXVolume, DialogVolume;
var String Resolution, AALevel;
var int CursorSensitivity;
var int AAIndex;

function bool save_options()
{
	if(class'Engine'.static.BasicSaveObject(self, "C:/Landfall/Options.dat",false,0))
	{
		return true;
	}
	else
	{
		return false;
	}


}

static function LF_options_save_info load_options()
{
	local LF_options_save_info op_save_info;
	
	op_save_info = new class'LF_options_save_info';
	
	if(!class'Engine'.static.BasicLoadObject(op_save_info, "C:/Landfall/Options.dat",false,0))
	{
		return none;
	}
	else
	{
		return op_save_info;
	}

}

defaultproperties
{
	Brightness = 3;
	MasterVolume = 3
	MusicVolume = 3
	FXVolume = 3
	DialogVolume = 3
	CursorSensitivity = 6
	TextureLevel = 8
	AALevel = "off"
	FOVLevel = 3
	Resolution = "1280x720"
	AAIndex = 0;
}