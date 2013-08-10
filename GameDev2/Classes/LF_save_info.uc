class LF_save_info extends Object;

var int loc_x,loc_y,loc_z;

var bool mission_1,mission_2,mission_3,mission_4,mission_5;
var int flashlight_state;
var string map_name;
//var testweapon fp_arms;

function bool save_game()
{
	if(class'Engine'.static.BasicSaveObject(self, "C:/Landfall/GameInfo.dat",false,0))
	{
		return true;
	}
	else
	{
		return false;
	}
}
static function LF_save_info load_options()
{
	local LF_save_info save_info;
	
	save_info = new class'LF_save_info';
	if(!class'Engine'.static.BasicLoadObject(save_info, "C:/Landfall/GameInfo.dat",false,0))
	{
		return none;
	}
	else
	{
		return save_info;
	}

}
defaultproperties
{
loc_x = 28011;
loc_y = 119499;
loc_z = -2209;
flashlight_state = 0;
mission_1 = false;
mission_2 = false;
mission_3 = false;
mission_4 = false;
mission_5 = false;
map_name = "base"
}
