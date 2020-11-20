-- This is the main script for heist game mode:
-- * Identifies the goal and all targets in the level
-- * Starts a timer when the alarm goes off
-- * Tracks mission time and time limit, if present
-- * Removes targets when they are picked up or moved to the goal trigger
-- * Communicates state and progression to HUD script through global variables
-- * Plays appropriate music depending on state

#include "common.lua"

pTimeLimit = GetFloatParam("timelimit", 0)
pRequired = GetIntParam("required", 0)
pAmmo = GetStringParam("ammo", "")
pMusic = GetStringParam("music", "")
pFireAlarm = GetBoolParam("firealarm", true)
pFireDispatch = GetBoolParam("firedispatch", false)

function init()
	SetFloat("level.missiontime", 0)
	SetFloat("level.alarmtimer", 60)
	SetFloat("level.timelimit", pTimeLimit)
	SetBool("level.alarm", false)
	SetString("level.state", "")

	targets = FindBodies("target", true)
	targetShapeCount = {}
	secondaryCount = 0
	primaryCount = 0	
	for i=1,#targets do
		if HasTag(targets[i], "optional") then
			secondaryCount = secondaryCount + 1
		else
			primaryCount = primaryCount + 1
		end
		if GetTagValue(targets[i], "target") == "" then
			SetTag(targets[i], "interact")
		end
		local shapes = GetBodyShapes(targets[i])
		targetShapeCount[targets[i]] = #shapes
	end

	SetBool("level.firealarm", pFireAlarm)

	--If the required number of targets is not specified as parameter it defaults to number of primary targets
	if pRequired > 0 then
		requiredCount = pRequired
	else
		requiredCount = primaryCount
		if requiredCount == 0 then
			requiredCount = secondaryCount
		end
	end

	SetInt("level.primary", primaryCount)
	SetInt("level.secondary", secondaryCount)
	SetInt("level.required", requiredCount)

	goal = FindTrigger("goal", true)

	clearedPrimary = 0
	clearedSecondary = 0
	
	targetSound = LoadSound("pickup")
	alarmBackgroundLoop = LoadLoop("alarm-background.ogg")

	--Ammo override
	if pAmmo ~= "" then
		local t = 1
		for word in string.gmatch(pAmmo, '([^,]+)') do
			local c = tonumber(word)
			local tool = GetString("game.tool."..t)
			ClearKey("game.tool."..tool)
			if c and c > 0 then
				SetBool("game.tool."..tool..".enabled", true)
				SetInt("game.tool."..tool..".ammo", c)
			end
			t = t + 1
		end		
	end
end


function isTargetBroken(target)
	local shapes = GetBodyShapes(target)
	if #shapes < targetShapeCount[target] then
		return true
	end
	for i=1,#shapes do
		if IsShapeBroken(shapes[i]) then
			return true
		end
	end
	return false
end


function clearTarget(target)
	PlaySound(targetSound)

	if HasTag(target, "optional") then
		clearedSecondary = clearedSecondary + 1
	else
		clearedPrimary = clearedPrimary + 1
	end

	SetInt("level.clearedprimary", clearedPrimary)
	SetInt("level.clearedsecondary", clearedSecondary)
end


function tick(dt)
	--Play music on win and lose
	local state = GetString("level.state")
	if state ~= "" then
		if state == "win" then
			PlayMusic("music/win.ogg")
		else
			PlayMusic("music/fail.ogg")
		end
		return
	end

	--Tick down alarm timer and lose if it reaches zero
	if GetBool("level.alarm") then
		local t = GetFloat("level.alarmtimer")
		t = t - dt
		if t <= 0.0 then
			t = 0.0
			SetString("level.state", "fail_alarmtimer")
		end
		SetFloat("level.alarmtimer", t)
		PlayMusic("music/heist.ogg")
		PlayLoop(alarmBackgroundLoop)
	else
		if pMusic ~= "" then
			PlayMusic("music/"..pMusic)
		else
			StopMusic()
		end

		--Set off alarm if a lot of fires
		if pFireAlarm and GetFireCount() >= 100 then
			if pFireDispatch then
				if not GetBool("level.dispatch") then
					SetBool("level.dispatch", true)
					SetString("hud.notification", "Chopper noticed the fire")
				end
			else
				SetBool("level.alarm", true)
				SetString("hud.notification", "Alarm triggered by fire")
			end
		end
	end

	--Tick mission time
	local missionTime = GetFloat("level.missiontime")
	missionTime = missionTime + dt
	--Lose if passed time limit
	local timeLimit = GetFloat("level.timelimit")
	if timeLimit > 0 and missionTime >= timeLimit then
		missionTime = timeLimit
		SetString("level.state", "fail_missiontimer")
	end
	SetFloat("level.missiontime", missionTime)
	
	local allPrimaryTargetsCleared = true
	for i=1, #targets do
		if IsHandleValid(targets[i]) then
			--Draw target outline
			local dist = VecLength(VecSub(GetPlayerPos(), GetBodyTransform(targets[i]).pos))
			if dist < 8 then
				if IsBodyInteractable(targets[i]) then
					DrawBodyOutline(targets[i], 1.0)
				else
					DrawBodyOutline(targets[i], 0.6*(1-dist/8))
				end
			end

	
			if IsBodyPicked(targets[i]) then
				if HasTag(targets[i], "optional") then
					SetString("level.pickinfo", "Target")
				else
					SetString("level.pickinfo", "Primary target")
				end
			end

			if not HasTag(targets[i], "optional") then
				allPrimaryTargetsCleared = false
			end
				
			local targetType = GetTagValue(targets[i], "target")
			if targetType == "heavy" then
				if IsBodyInTrigger(goal, targets[i]) then
					clearTarget(targets[i])
					Delete(targets[i])
				end
			elseif targetType == "destroy" then
				if isTargetBroken(targets[i]) then
					clearTarget(targets[i])
					RemoveTag(targets[i], "target")
					targets[i] = 0
				end
			elseif targetType == "cleared" then
				clearTarget(targets[i])
				RemoveTag(targets[i], "target")
				targets[i] = 0
			elseif targetType == "custom" then
				--Cleared logic is in some other script for custom targets
			else
				if IsBodyOperated(targets[i]) then
					if GetString("game.levelid") == "lee_login" and not GetBool("game.canquickload") and not GetBool("level.alarm") then
						SetBool("hud.quicksavehint", true)
						Command("game.pause")
					else
						clearTarget(targets[i])
						Delete(targets[i])
					end
				end
			end
		end
	end

	-- Complete when cleared target count is at least the required count AND all primary (if any) are cleared
	local complete = clearedPrimary + clearedSecondary >= requiredCount
	if primaryCount > 0 and clearedPrimary < primaryCount then
		complete = false
	end
	SetBool("level.complete", complete)
end

