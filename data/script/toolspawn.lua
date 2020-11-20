#include "common.lua"
#include "game.lua"

pTool = GetStringParam("tool", "none")

function init()
	body = FindBody("tool")
	transform = GetBodyTransform(body)
	SetBodyTransform(body, Transform(Vec(0,-20,0), Quat()))
	snd = LoadSound("tool_pickup")
	spawned = false
	arrow = LoadSprite("gfx/arrowdown.png")
	upgradeTimer = 0
end

function tick(dt)
	if not spawned and not GetBool("game.tool."..pTool..".enabled") then
		local score = GetInt("savegame.hub.score")
		for i=1,#gRanks do
			if score >= gRanks[i].score and gRanks[i].tool == pTool then
				SetBodyTransform(body, transform)
				SetTag(body, "interact", true)
				spawned = true
				SetBool("level.toolspawn", true)
			end
		end
	end
	
	if spawned then
		if body ~= nil then
			if IsBodyInteractable(body) then
				SetString("level.interactinfo", "Pick up")
			else
				local t = Transform(transform)
				t.rot = QuatLookAt(t.pos, GetCameraTransform().pos)
				local offset = 3 + math.sin(4.0*GetTime())*0.5
				t.pos[2] = t.pos[2] + offset
				DrawSprite(arrow, t, 2, 2, 1, 1, 1, 1, false, true)
			end
		end
		if IsBodyOperated(body) then
			PlaySound(snd)
			SetBool("savegame.tool."..pTool..".enabled", true)
			SetString("game.player.tool", pTool)
			SetBool("game.tool."..pTool..".enabled", true)
			Delete(body)
			body = nil
			upgradeTimer = 3
			--Copy over default configuration for tool
			for j=1, #gTools[pTool].upgrades do
				local id = gTools[pTool].upgrades[j].id
				local value = gTools[pTool].upgrades[j].default
				local saved = GetInt("savegame.tool."..pTool.."."..id)
				if saved > value then
					value = saved 
				end
				SetInt("game.tool."..pTool.."."..id, value)
			end

			if pTool == "plank" then
				SetBool("hud.tooltutorial", true)
				Command("game.pause")
			end
			SetBool("level.toolspawn", false)
		end
	end	
	
	if upgradeTimer > 0 then
		upgradeTimer = upgradeTimer - GetTimeStep()
		if upgradeTimer <= 0 then
			SetString("hud.notification", "You can upgrade your tools in the computer terminal")
		end
	end
end
