#include "common.lua"

pTool = GetStringParam("tool", "none")

function init()
	body = FindBody("tool")
	snd = LoadSound("tool_pickup")
	SetTag(body, "interact", true)
end

function tick(dt)
	if GetBool("game.tool."..pTool..".enabled") then
		Delete(body)
		body = nil
	end
	if body ~= nil then
		if IsBodyInteractable(body) then
			SetString("level.interactinfo", "Pick up")
		end
		if IsBodyOperated(body) then
			PlaySound(snd)
			SetBool("savegame.tool."..pTool..".enabled", true)
			SetString("game.player.tool", pTool)
			SetBool("game.tool."..pTool..".enabled", true)
			Delete(body)
			body = nil
		end
	end
end
