-- Alarm box will blink periodically when alarm is not triggered and
-- faster when alarm is triggered. Alarm is triggered if ay of:
-- 1) Box is broken
-- 2) Box becomes dynamic (detached from static object)
-- 3) Any joint (or rope) connected to this box is detached

function init()
	box = FindShape("alarmbox")
	tube = FindShape("tube")
	doBlink = true
	--isWhole = true
	SetShapeEmissiveScale(box, 0)
	blinkTimer = 0
	--SetInt("level.remainingexplosive", GetInt("level.remainingexplosive")+1)
end


function tick(dt)
	blinkTimer = blinkTimer + dt
	local t = math.mod(blinkTimer, 1.0)
	local alarm = GetBool("level.alarm")

	if doBlink then
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
	else
		SetShapeEmissiveScale(box, 0)
	end

	--Check if the tube is broken
	--if isWhole then
	--	if IsShapeBroken(tube) then
	--		SetInt("level.remainingexplosive", GetInt("level.remainingexplosive")-1)
	--		isWhole = false
	--	end
	--end

	--Check if alarm should be triggered
	if not alarm then
		--print(IsShapeBroken(tube), IsShapeBroken(box), IsHandleValid(tube), IsHandleValid(box))
		if IsShapeBroken(tube) or IsShapeBroken(box) then
			SetBool("level.alarm", true)
			blinkTimer = 0
			doBlink = false
		end
	end
end

