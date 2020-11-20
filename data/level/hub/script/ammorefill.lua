#include "game.lua"

isOutsideTrigger = true

function init()
	ammotrigger = FindTrigger("Ammotrigger")
	refillSound = LoadSound("tool_pickup")
end

function tick(dt)
	if IsPointInTrigger(ammotrigger, GetPlayerPos()) then
		if isOutsideTrigger then
			local didReload = false
			for id,tool in pairs(gTools) do
				local enabled = GetBool("game.tool."..id..".enabled")
				if enabled then
					for j=1, #tool.upgrades do
						local prop = tool.upgrades[j].id
						local value = tool.upgrades[j].default
						local saved = GetInt("savegame.tool."..id.."."..prop)
						if saved > value then
							value = saved
						end
						SetInt("game.tool."..id.."."..prop, value)
					end
				end
			end
			PlaySound(refillSound)
			SetString("hud.notification", "Ammo refill")
		end
		isOutsideTrigger = false
	else
		isOutsideTrigger = true
	end
end
