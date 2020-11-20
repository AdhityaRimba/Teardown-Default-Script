
function init()
	motor = FindJoint("motor")
	trigger = FindTrigger("open")
	pos = GetTriggerTransform(trigger).pos
	open = false
	doors = LoadSound("doors.ogg")
	eps = 0.2
	timer = 0
end

function update(dt)
	local p = GetPlayerPos()
	local vehicle = GetBool("game.player.usevehicle")

	timer = timer + GetTimeStep()
	if IsPointInTrigger(trigger, p) and vehicle then
		if timer < 8 then
			SetJointMotor(motor, -4)
		end
		if not open then
			PlaySound(doors, pos)
			timer = 0
		end
		open = true
	else
		if timer < 8 then
			SetJointMotor(motor, 1)
		end
		if open then
			PlaySound(doors, pos)
			timer = 0
		end
		open = false
	end
end

