#include "common.lua"

function init()
	alarmed = GetIntParam("alarmed",0)
	teslacube = FindShape("teslacube")
	sparks = FindBodies("spark")
	sparkTransforms = {}
	otherShapes = {}
	for i = 1,#sparks do
		sparkTransforms[i] = GetBodyTransform(sparks[i])
		SetBodyTransform(sparks[i], Transform(Vec(0,10000,0), Quat()))
		SetShapeEmissiveScale(sparks[i], 0)
	end

	local joints = GetJointsConnectedToShape(teslacube)
	wires = {}
	for i=1,#joints do
		if GetJointType(joints[i]) == 4 then
			wires[#wires+1] = joints[i]
			otherShapes[#wires] = GetOtherJointShape(joints[i],teslacube)
		end
	end

	sparkSounds = LoadSound("spark")
	random = (math.random(2)-1)*0.5
	justSparked = false
	sparkTimer = 0
end

function tick(dt)
	local triggerAlarm = false
	for i=1,#wires do
		if IsJointBroken(wires[i]) then
			triggerAlarm = true
		end

		local currentOtherShape = GetOtherJointShape(wires[i],teslacube)
		if currentOtherShape ~= otherShapes[i] then
			triggerAlarm = true
		end
	end

	if IsShapeBroken(teslacube) or triggerAlarm then
		if alarmed == 1 then
			SetBool("level.alarm", true)
		end
		for i = 1,#sparks do
			if justSparked then
				SetBodyTransform(sparks[rndSpark], Transform(Vec(0,10000,0), Quat()))
				SetShapeEmissiveScale(sparks[rndSpark], 0)
				justSparked = false
			end		
		end
	else
		if justSparked then
			SetShapeEmissiveScale(sparks[rndSpark], sparkTimer*4)
			if sparkTimer < 0 then
				random = (math.random(2)-1)*0.5
				SetBodyTransform(sparks[rndSpark], Transform(Vec(0,10000,0), Quat()))
				SetShapeEmissiveScale(sparks[rndSpark], 0)
				justSparked = false
			end
		end
		if random < 0 and not justSparked then
			rndSpark = math.random(#sparks)
			SetBodyTransform(sparks[rndSpark], sparkTransforms[rndSpark])
			SetShapeEmissiveScale(sparks[rndSpark], 1)
			justSparked = true
			sparkTimer = 0.1
			PlaySound(sparkSounds,GetBodyTransform(sparks[rndSpark]).pos)
		end
	end

	random = random - dt
	sparkTimer = sparkTimer - dt
end
