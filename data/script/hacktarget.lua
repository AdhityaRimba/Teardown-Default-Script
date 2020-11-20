#include "common.lua"

pMessage = GetStringParam("message", "Hacking")
pDuration = GetFloatParam("duration", 2.0)
pSound = GetStringParam("sound", "transmission.ogg")

JOINTED_STATIC = 1
JOINTED_DYNAMIC = 2
FIXED_STATIC = 3
FIXED_DYNAMIC = 4

function init()
	body = FindBody("target")
	hackpanel = FindShape("hack")
	dynamic = IsShapeDynamic(hackpanel)
	light = FindLight("light")

	local joints = GetJointsConnectedToShape(hackpanel)
	joint = joints[1]

	if joint then
		local s = GetOtherJointShape(joint, hackpanel)
		if IsShapeDynamic(s) then
			type = JOINTED_DYNAMIC
			initialMass = GetBodyMass(GetShapeBody(s))
		else
			type = JOINTED_STATIC
		end
	else
		if IsShapeDynamic(hackpanel) then
			type = FIXED_DYNAMIC
			initialMass = GetBodyMass(GetShapeBody(hackpanel))
		else
			type = FIXED_STATIC
		end
	end

	SetTag(body, "interact")
	progress = 0
	snd = LoadLoop(pSound)

	tampered = false
	hacked = false
	dispatched = false
end


function tick(dt)
	local triggerDispatch = false

	if not hacked then
		if IsBodyInteractable(body) then
			SetString("level.interactinfo", "Hack target")
		end
		if IsBodyOperated(body, true) then
			progress = progress + dt
			local t = clamp(progress / pDuration, 0, 1)
			if t == 1 then
				SetTag(body, "target", "cleared")
				hacked = true
			else
				SetBool("level.hacking", true)
				SetFloat("hud.progressbar", t)
				SetString("hud.progressbar.title", pMessage)
				PlayLoop(snd, GetBodyTransform(body).pos)
			end
		else
			progress = 0
		end
	end

	if not tampered then
		if type == FIXED_STATIC then
			if IsShapeDynamic(hackpanel) then
				tampered = true
			end
		elseif type == FIXED_DYNAMIC then
			local currentMass = GetBodyMass(GetShapeBody(hackpanel))
			if currentMass < 0.5 * initialMass then
				tampered = true
			end
		elseif type == JOINTED_STATIC then
			if IsJointBroken(joint) then
				tampered = true
			else
				local s = GetOtherJointShape(joint, hackpanel)
				if IsShapeDynamic(s) then
					tampered = true
				end
			end
		elseif type == JOINTED_DYNAMIC then
			if IsJointBroken(joint) then
				tampered = true
			else
				local s = GetOtherJointShape(joint, hackpanel)
				local currentMass = GetBodyMass(GetShapeBody(s))
				if currentMass < 0.5 * initialMass then
					tampered = true
				end
			end
		end
	end

	if not dispatched and (tampered or hacked) then
		SetBool("level.dispatch", true)
		dispatched = true
	end

	local period = 0.8
	if tampered then
		period = 0.4
		SetLightColor(light, 1, .1, .1)
	end
	if hacked then
		SetShapeEmissiveScale(hackpanel, 0)
	else
		if math.mod(GetTime(), period) < 0.1 then
			SetShapeEmissiveScale(hackpanel, 1)
		else
			SetShapeEmissiveScale(hackpanel, 0)
		end
	end
end


