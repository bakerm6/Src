class EGG_test_hud extends HUD;

var Font Player_Font;

function PostRender()
{
	local float CrosshairSize;
	super.PostRender();
	CrosshairSize = 4;
	Canvas.SetDrawColor(0,255,0,255);
	Canvas.SetPos(CenterX - CrosshairSize, CenterY);
	Canvas.DrawRect(2*CrosshairSize + 1, 1);
	Canvas.SetPos(CenterX, CenterY - CrosshairSize);
	Canvas.DrawRect(1, 2*CrosshairSize + 1);
	Canvas.Font = Player_Font;
	Canvas.SetPos(70, 100);
	Canvas.DrawText("EGG_HUD");
}

defaultproperties
{
	Player_Font= "UI_Fonts.MultiFonts.MF_HudSmall"
}