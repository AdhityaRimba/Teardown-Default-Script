-- Light switch script. Allows the player to operate light switches.
-- Each lightswitch should have the "lightswitch" tag, with tag value being
-- the corresponding light source tag they control. 
-- This script supports several light swiches with different tag values.
-- Light sources always start disabled

#include "common.lua"

function init()
	lightSwitches = FindShapes("lightswitch")
	lightOn = {}
	
	for i=1, #lightSwitches do
		lightOn[i] = false
		local t = GetTagValue(lightSwitches[i], "lightswitch")
		setLightsEnabled(t, false)
		SetTag(lightSwitches[i], "interact")
	end
	
	clickUp = LoadSound("clickup")
	clickDown = LoadSound("clickdown")
end


function setLightsEnabled(tag, enabled)
	local lights = FindLights(tag)
	for i=1, #lights do
		SetLightEnabled(lights[i], enabled)
	end
end


function press(shape)
	PlaySound(clickDown)
	local t = GetShapeWorldTransform(shape)
	t.pos[2] = t.pos[2] + 0.1
	SetShapeWorldTransform(shape, t)
	setLightsEnabled(GetTagValue(shape, "lightswitch"), true)
end


function unpress(shape)
	PlaySound(clickUp)
	local t = GetShapeWorldTransform(shape)
	t.pos[2] = t.pos[2] - 0.1
	SetShapeWorldTransform(shape, t)
	setLightsEnabled(GetTagValue(shape, "lightswitch"), false)
end


function tick(dt)
	for i=1, #lightSwitches do
		if IsShapeInteractable(lightSwitches[i]) then
			DrawShapeOutline(lightSwitches[i], 1)
			if lightOn[i] then
				SetString("level.interactinfo", "Turn off")
			else
				SetString("level.interactinfo", "Turn on")
			end
		end
		if IsShapeOperated(lightSwitches[i]) and not IsShapeDynamic(lightSwitches[i]) then
			if not lightOn[i] then
				press(lightSwitches[i])
				lightOn[i] = true
			else
				unpress(lightSwitches[i])
				lightOn[i] = false
			end
		end
	end
end

