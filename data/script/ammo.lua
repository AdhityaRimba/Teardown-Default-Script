#include "common.lua"

amount = GetIntParam("amount", 4)
tool = GetStringParam("tool", "none")
remain = GetBoolParam("remain", false)
refillSound = LoadSound("tool_pickup")

function init()
	ammo = FindBody("ammo")
	SetTag(ammo, "interact")
end

function tick(dt)
	if IsBodyInteractable(ammo) then
		DrawBodyOutline(ammo, 1)
		SetString("level.interactinfo", "Pick up")
	end
	if IsBodyOperated(ammo) then
		SetBool("game.tool." .. tool .. ".enabled",true)
		SetString("game.player.tool",tool)
		currentAmmo = GetInt("game.tool." .. tool .. ".ammo")
		PlaySound(refillSound,GetBodyTransform(ammo).pos)
		if remain then
			SetInt("game.tool." .. tool .. ".ammo", amount)
		else
			SetInt("game.tool." .. tool .. ".ammo", currentAmmo + amount)
			Delete(ammo)
		end
	end
end
