pSpeed = GetFloatParam("speed", 2.0)
power = GetFloatParam("power", 0)

function init()
	motor = FindJoint("motor")
	button = FindShape("button")

	buttonbody = FindBody("button")
	buttont = GetBodyTransform(buttonbody)

	motorbody = FindBody("motor")
	motorbodyt = GetBodyTransform(motorbody)

	limitMin, limitMax = GetJointLimits(motor)


	clickUp = LoadSound("clickup")
	clickDown = LoadSound("clickdown")
	motorSound = LoadLoop("vehicle/hydraulic-loop")
	stuckSound = LoadLoop("LEVEL/script/garagebeam/hydraulic-loop-stuck")
	stopSound = LoadSound("metal/hit-m")

	timer = 0.0
	buttonUp = false
	isMoving = false
	lastMotorPos = GetJointMovement(motor)

end


function tick(dt)
	timer = timer + dt
	
	if IsShapeOperated(button) then
		local t = GetShapeLocalTransform(button)
		if buttonUp then
			PlaySound(clickDown, t.pos)
			t.pos[1] = t.pos[1] + 0.1
			SetShapeLocalTransform(button, t)

			lastMotorPos = GetJointMovement(motor) + 0.1
			buttonUp = false
			--print("buttonUp: false")
		else
			PlaySound(clickUp,t.pos)
			t.pos[1] = t.pos[1] - 0.1
			SetShapeLocalTransform(button, t)

			lastMotorPos = GetJointMovement(motor) - 0.1
			buttonUp = true
			--print("buttonUp: true")
		end
	end

	eps = 0.05
	if buttonUp then -- Moving on up!!
		if GetJointMovement(motor) <= lastMotorPos and isMoving then -- Are we stuck?
			PlayLoop(stuckSound, motorbodyt.pos)
		else
			lastMotorPos = GetJointMovement(motor)
			if GetJointMovement(motor) < limitMax-eps then
				SetJointMotor(motor, -pSpeed, power)
				PlayLoop(motorSound, motorbodyt.pos)
				isMoving = true
			else
				if isMoving then
					PlaySound(stopSound)
				end
				isMoving = false
			end
		end
	else -- Getting back down...
		if GetJointMovement(motor) >= lastMotorPos and isMoving then -- Are we stuck?
			PlayLoop(stuckSound, motorbodyt.pos)
		else
			lastMotorPos = GetJointMovement(motor)
			if GetJointMovement(motor) > limitMin+eps then
			SetJointMotor(motor, pSpeed, power)
			PlayLoop(motorSound, motorbodyt.pos)
			isMoving = true
			else
				if isMoving then
					PlaySound(stopSound, motorbodyt.pos)
				end
				isMoving = false
			end
		end
	end
end
