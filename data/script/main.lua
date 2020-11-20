#include "common.lua"
#include "game.lua"

function init()
	enableValuabes = not string.find(GetString("game.levelid"), "sandbox")
	valuableSound = LoadSound("valuable")
	initValuables()

	--Just to make sure the base tools are always available except for tutorial hub
	SetBool("savegame.tool.sledge.enabled", true)
	SetBool("savegame.tool.spraycan.enabled", true)
	SetBool("savegame.tool.extinguisher.enabled", true)
	
	--Copy savegame tools properties over to volatile game properties
	for id,tool in pairs(gTools) do
		local enabled = GetBool("savegame.tool."..id..".enabled")
		if enabled then
			SetBool("game.tool."..id..".enabled", true)
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
end

function handleCommand(cmd)
	if cmd == "quickload" then
		--After quickload, make sure valuables are consistent with savegame
		initValuables()
	end
end

function initValuables()
	if enableValuabes then
		valuables = FindBodies("valuable", true)
		local valueMin = 10000
		local valueMax = 0
		local valueTotal = 0
		for i=1,#valuables do
			local id = GetTagValue(valuables[i], "valuable")
			local v = tonumber(GetTagValue(valuables[i], "value"))
			valueMin = math.min(valueMin, v)
			valueMax = math.max(valueMax, v)
			valueTotal = valueTotal + v
			if GetBool("savegame.valuable."..id) then
				Delete(valuables[i])
			end
		end
		--print(#valuables .. " valuables worth $" .. valueTotal ..  " ($" .. valueMin .. "-$" .. valueMax .. ")")
		valuables = FindBodies("valuable", true)
		for i=1,#valuables do
			SetTag(valuables[i], "interact")
		end
		valuableAlpha = {}
	end
end

function tick(dt)
	--Set state if player dies
	if GetFloat("game.player.health") == 0 then
		SetString("level.state", "fail_dead")
	end
	
	--Handle valuables
	if enableValuabes then
		local cp = GetPlayerPos()
		for i=1, #valuables do
			local s = valuables[i]
			if IsHandleValid(s) then
				--Remove if broken
				if IsBodyBroken(s) then
					RemoveTag(s, "valuable")
					valuables[i] = nil
				end

				--Outline and picking info
				local pos = GetBodyTransform(s).pos
				local d = VecLength(VecSub(pos, cp))
				if IsBodyVisible(s, 6) then
					if valuableAlpha[s] == nil then
						valuableAlpha[s] = 1
					end
				else
					valuableAlpha[s] = nil
				end
				if IsBodyInteractable(s) then
					SetString("level.interactinfo", "Grab valuable")
				end
				if IsBodyPicked(s) then
					SetString("level.pickinfo", "Value $"..GetTagValue(s, "value"))
				end
				if valuableAlpha[s] then
					valuableAlpha[s] = valuableAlpha[s] - GetTimeStep()*2
					if valuableAlpha[s] > 0 then
						DrawBodyHighlight(s, valuableAlpha[s])
					end
				end

				--Clear if operated
				if IsBodyOperated(s) then
					local id = GetTagValue(s, "valuable")
					SetBool("savegame.valuable."..id, true);
					local value = tonumber(GetTagValue(s, "value"))
					if not value then value = 0 end
					SetInt("savegame.cash", GetInt("savegame.cash") + value)
					SetString("hud.notification", "Picked up "..GetDescription(s).." worth $"..value)
					Delete(s)
					PlaySound(valuableSound)
				end
			end
		end
	end
end


