function init()
	enabled = true
	if GetBool("savegame.mission.mall_intro") then
		enabled = false
		local loc = FindLocation("defaultplayer", true)
		SetPlayerTransform(GetLocationTransform(loc))
		return
	end

	gateLocation = FindLocation("gate")
	gateTrigger = FindTrigger("gate")
	gateNearTrigger = FindTrigger("gatenear")
	gateDoneTrigger = FindTrigger("gatedone")
	gateNear = false
	gateDone = false

	doorLocation = FindLocation("door")
	doorTrigger = FindTrigger("door")
	doorRubbleTrigger = FindTrigger("rubble")
	doorDoneTrigger = FindTrigger("doordone")
	doorRubbleDone = false
	doorDone = false
	
	toolsLocation = FindLocation("tools")
	toolsTrigger = FindTrigger("tools")
	toolsDone = false

	fuseLocation = FindLocation("fuse")
	fuseOutsideTrigger = FindTrigger("fuseoutside")
	fuseInsideTrigger = FindTrigger("fuseinside")
	fuseLight = FindShape("fuselight")
	fuseBody = FindBody("fuse")
	fuseDone = false

	terminalLocation = FindLocation("terminal")
	terminalTrigger = FindTrigger("terminal")
	terminalDone = false
	
	powerOn = LoadSound("LEVEL/script/tutorial/poweron.ogg")
	arrow = LoadSprite("gfx/arrowdown.png")
	
	tv = FindScreen("tv", true)
	SetTag(tv, "disabled")
	terminal = FindScreen("terminal", true)
	SetTag(terminal, "disabled")
	
	lights = FindShapes("light", true)
	for i=1, #lights do
		SetShapeEmissiveScale(lights[i], 0)
	end
	
	--Disable all tools
	local tools = ListKeys("game.tool")
	for i=1,#tools do
		local k = "game.tool."..tools[i]..".enabled"
		if GetBool(k) then
			SetBool(k, false)
		end
	end
	SetString("game.player.tool", "none")	
	
	--gateDone = true
	--doorDone = true
	--toolsDone = true
	
	bus = FindBody("bus")
	busVel = Vec(0,0,0)
	busTransform = GetBodyTransform(bus)
	busSound = LoadSound("LEVEL/script/tutorial/bus.ogg")
	busActive = false
end


function drawArrow(location)
	local t = GetLocationTransform(location)
	t.rot = QuatLookAt(t.pos, GetCameraTransform().pos)
	local offset = 1.5 + math.sin(4.0*GetTime())*0.5
	t.pos[2] = t.pos[2] + offset
	DrawSprite(arrow, t, 2, 2, .3, .3, .3, 3, false, true)
	DrawSprite(arrow, t, 2, 2, 1, 1, 1, 1, true, true)
end


function tick(dt)
	if not enabled then
		return
	end

	if GetTime() > 2.5 then
		if not busActive then
			PlaySound(busSound)
			busActive = true
		end
		local fwd = TransformToParentVec(busTransform, Vec(0, 0, 1))
		busVel = VecAdd(busVel, VecScale(fwd, dt*2.0))
		busTransform.pos = VecAdd(busTransform.pos, VecScale(busVel, dt))
		SetBodyTransform(bus, busTransform)
	end

	local p = GetPlayerPos()
	if not gateDone then
		if IsPointInTrigger(gateTrigger, p) then
			SetString("hud.hintimage", "ui/hud/tutorial/opendoor.png")
		else
			if not gateNear and IsPointInTrigger(gateNearTrigger, p) then
				gateNear = true
			end
			if gateNear then
				SetString("hud.hintinfo", "Open the gate")
				drawArrow(gateLocation)
			else
				SetString("hud.hintinfo", "Walk home")
			end
		end
		if IsPointInTrigger(gateDoneTrigger, p) then
			gateDone = true
		end
	elseif not doorDone then
		if IsPointInTrigger(doorTrigger, p) then
			if not doorRubbleDone and IsTriggerEmpty(doorRubbleTrigger) then
				doorRubbleDone = true
			end
			if doorRubbleDone then
				SetString("hud.hintimage", "ui/hud/tutorial/opendoor.png")
			else
				SetString("hud.hintimage", "ui/hud/tutorial/hold.png")
			end
		else
			SetString("hud.hintinfo", "Go inside")
			drawArrow(doorLocation)
		end
		if IsPointInTrigger(doorDoneTrigger, p) then
			doorDone = true
		end
	elseif not toolsDone then
		if not IsPointInTrigger(toolsTrigger, p) then
			SetString("hud.hintinfo", "Pick up your tools")
			drawArrow(toolsLocation)
		end
		if GetBool("game.tool.sledge.enabled") and GetBool("game.tool.spraycan.enabled") and GetBool("game.tool.extinguisher.enabled") then
			toolsDone = true
		end
	elseif not fuseDone then
		SetTag(fuseBody, "interact", true)
		if IsPointInTrigger(fuseOutsideTrigger, p) then
			SetString("hud.hintimage", "ui/hud/tutorial/usetool.png")
		elseif IsPointInTrigger(fuseInsideTrigger, p) then
			SetString("hud.hintimage", "ui/hud/tutorial/flashlight.png")
		else
			SetString("hud.hintinfo", "Replace the fuse to turn on power")
			drawArrow(fuseLocation)
		end
		if IsBodyInteractable(fuseBody) then
			SetString("level.interactinfo", "Replace fuse")
		end
		if IsBodyOperated(fuseBody) then
			SetTag(fuseBody, "interact", false)
			PlaySound(powerOn)
			fuseDone = true
			SetShapeEmissiveScale(fuseLight, 0)
			for i=1, #lights do
				SetShapeEmissiveScale(lights[i], 1)
			end
			RemoveTag(tv, "disabled")
			RemoveTag(terminal, "disabled")
		end
	elseif not terminalDone then
		if not IsPointInTrigger(fuseInsideTrigger, p) then
			if not IsPointInTrigger(terminalTrigger, p) then
				SetString("hud.hintinfo", "Go inside and check messages")
				drawArrow(terminalLocation)
			end
			if GetBool("game.player.usescreen") then
				terminalDone = true
			end
		end
	end
end
