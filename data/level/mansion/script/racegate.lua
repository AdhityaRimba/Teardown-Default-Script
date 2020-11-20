pId = GetIntParam("id", 1)

function init()
	gate = FindBody("gate")
	shape = FindShape("gate")
	light = FindShape("light")

	trigger = FindTrigger("trigger")

	frame = 0
	broken = false
end


function update(dt)
	frame = frame + 1
end


function tick(dt)
	local gatePos = GetBodyTransform(gate).pos
	local triggerTransform = GetTriggerTransform(trigger)
	triggerTransform.pos[1] = gatePos[1]
	triggerTransform.pos[3] = gatePos[3]
	SetTriggerTransform(trigger, triggerTransform)

	local reg = "level.track.gate."..pId
	
	local active = IsBodyJointedToStatic(gate)
	if active then
		SetShapeEmissiveScale(shape, 1.0)
	else
		SetShapeEmissiveScale(shape, 0.0)
		if not broken then
			SetString("hud.notification", "Gate broken")
		end
		broken = true
		SetBool("level.track.gatebroken", broken)
	end
	local vehicle = GetPlayerVehicle()
	SetBool(reg, not broken and IsVehicleInTrigger(trigger, vehicle))
	
	local emissive = 0.0
	if GetBool(reg) then
		emissive = 1.0
	end
	
	SetShapeEmissiveScale(light, emissive)
end
