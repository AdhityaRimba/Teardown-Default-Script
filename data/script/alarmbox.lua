-- Alarm box will blink periodically when alarm is not triggered and
-- faster when alarm is triggered. Alarm is triggered if ay of:
-- 1) Box is broken
-- 2) Box is tampered with (multiple modes, depending on how the box is attached)
-- 3) Any rope connected to this box is detached

JOINTED_STATIC = 1
JOINTED_DYNAMIC = 2
FIXED_STATIC = 3
FIXED_DYNAMIC = 4

function init()
	box = FindShape("alarmbox")
	dynamic = IsShapeDynamic(box)

	local joints = GetJointsConnectedToShape(box)
	wires = {}
	wireVehicle = {}
	for i=1,#joints do
		if GetJointType(joints[i]) == 4 then
			wires[#wires+1] = joints[i]
			local otherShape = GetOtherJointShape(joints[i],box)
			wireVehicle[#wireVehicle+1] = GetBodyVehicle(GetShapeBody(otherShape))
		else
			joint = joints[i]
		end
	end

	if joint then
		local s = GetOtherJointShape(joint, box)
		if IsShapeDynamic(s) then
			type = JOINTED_DYNAMIC
			initialMass = GetBodyMass(GetShapeBody(s))
		else
			type = JOINTED_STATIC
		end
	else
		if IsShapeDynamic(box) then
			type = FIXED_DYNAMIC
			initialMass = GetBodyMass(GetShapeBody(box))
		else
			type = FIXED_STATIC
		end
	end

	SetShapeEmissiveScale(box, 0)
	blinkTimer = 0
end

function tick(dt)
	blinkTimer = blinkTimer + dt
	local t = math.mod(blinkTimer, 1.0)
	local alarm = GetBool("level.alarm")

	if alarm then
		--Alarm blink
		if t < 0.5 then
			SetShapeEmissiveScale(box, 1)
		else
			SetShapeEmissiveScale(box, 0)
		end
	else
		--Regular blink
		if t > 0.9 then
			SetShapeEmissiveScale(box, 0.5)
		else
			SetShapeEmissiveScale(box, 0)
		end
	end

	--Check if alarm should be triggered
	if not alarm then
		local triggerAlarm = false
		-- Trigger alarm if any wire is broken
		for i=1,#wires do
			if IsJointBroken(wires[i]) then
				triggerAlarm = true
			else
				if wireVehicle[i] ~= 0 then
					local otherShape = GetOtherJointShape(wires[i],box)
					if wireVehicle[i] ~= GetBodyVehicle(GetShapeBody(otherShape)) then
						triggerAlarm = true
					end
				end
			end
		end

		-- Trigger alarm if box is broken
		if IsShapeBroken(box) then
			triggerAlarm = true
		end

		if type == FIXED_STATIC then
			if IsShapeDynamic(box) then
				triggerAlarm = true
			end
		elseif type == FIXED_DYNAMIC then
			local currentMass = GetBodyMass(GetShapeBody(box))
			if currentMass < 0.5 * initialMass then
				triggerAlarm = true
			end
		elseif type == JOINTED_STATIC then
			if IsJointBroken(joint) then
				triggerAlarm = true
			else
				local s = GetOtherJointShape(joint, box)
				if IsShapeDynamic(s) then
					triggerAlarm = true
				end
			end
		elseif type == JOINTED_DYNAMIC then
			if IsJointBroken(joint) then
				triggerAlarm = true
			else
				local s = GetOtherJointShape(joint, box)
				local currentMass = GetBodyMass(GetShapeBody(s))
				if currentMass < 0.5 * initialMass then
					triggerAlarm = true
				end
			end
		end
		if triggerAlarm then
			SetBool("level.alarm", true)
			blinkTimer = 0
		end
	end
end

