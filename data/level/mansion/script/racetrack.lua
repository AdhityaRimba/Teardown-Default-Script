STATE_NONE = ""
STATE_READY = "ready"
STATE_START = "start"
STATE_RACE = "race"
STATE_FINISH = "finish"
STATE_BROKEN = "broken"


function init()
	state = ""
	startTrigger = FindTrigger("start")
	finishTrigger = FindTrigger("finish")
	timer = 0
	startFrame = 0
	finishFrame = 0
	finishFrame = 0
	readySnd = LoadSound("LEVEL/script/racetrack/ready.ogg")
	startSnd = LoadSound("LEVEL/script/racetrack/start.ogg")
	failSnd = LoadSound("LEVEL/script/racetrack/fail.ogg")
	cp1 = false
	cp2 = false
	cp3 = false
	cpSnd = LoadSound("LEVEL/script/racetrack/checkpoint.ogg")
	finishSnd = LoadSound("LEVEL/script/racetrack/finish.ogg")
	readyPos = Vec()
	bestTime = 30.32
	lastTime = 0
	timeNotInCar = 0
end


function update(dt)
	local driving = GetBool("game.player.usevehicle")
	local pos = GetPlayerPos()

	if driving then
		if state == STATE_NONE then
			if IsPointInTrigger(startTrigger, pos) then
				state = STATE_READY
				readyFrame = 0
			end
		end
		if state == STATE_READY then
			if IsPointInTrigger(startTrigger, pos) then
				if VecLength(VecSub(pos, readyPos)) > 0.1 then
					readyFrame = 0
					readyPos = Vec(pos)
				end
				readyFrame = readyFrame + 1
				if readyFrame == 90 then
					state = STATE_START
					startFrame = 0
				end
			else
				state = STATE_NONE
			end
		end
		if state == STATE_START then
			if IsPointInTrigger(startTrigger, pos) then
				if startFrame == 0 then
					PlaySound(readySnd)
				end
				if startFrame == 60 then
					PlaySound(readySnd)
				end
				if startFrame == 120 then
					PlaySound(readySnd)
				end
				if startFrame == 180 then
					PlaySound(startSnd)
					state = STATE_RACE
					timer = 0
					cp1 = false
					cp2 = false
					cp3 = false
					SetBool("level.track.gate.1", false)
					SetBool("level.track.gate.2", false)
					SetBool("level.track.gate.3", false)
				end
				startFrame = startFrame + 1
			else
				state = STATE_NONE
				PlaySound(failSnd)			
			end
		end
		if state == STATE_RACE then
			if not cp1 then
				if GetBool("level.track.gate.1") then 
					cp1 = true
					PlaySound(cpSnd)
				end
			end
			if not cp2 and cp1 then
				if GetBool("level.track.gate.2") then 
					cp2 = true
					PlaySound(cpSnd)
				end
			end
			if not cp3 and cp1 and cp2 then
				if GetBool("level.track.gate.3") then 
					cp3 = true
					PlaySound(cpSnd)
				end
			end
			if cp1 and cp2 and cp3 then
				if IsPointInTrigger(finishTrigger, pos) then 
					state = STATE_FINISH
					PlaySound(finishSnd)
					finishFrame = 0
					lastTime = timer
					if timer < bestTime then 
						bestTime = timer
					end
				end
			else
				if timer > 5 and IsPointInTrigger(startTrigger, pos) then 
					PlaySound(failSnd)
					state = STATE_NONE
				end
			end
		end
		if state == STATE_FINISH then
			finishFrame = finishFrame + 1
			if finishFrame > 120 then
				state = STATE_NONE
			end
		end
	else
		--If not driving and not in race, reset state
		if state ~= STATE_RACE then
			state = STATE_NONE
		end
	end

	--Abort race if player exit vehicle for ten seconds
	if driving then
		timeNotInCar = 0
	else
		timeNotInCar = timeNotInCar + dt
	end
	if timeNotInCar > 10 and state == STATE_RACE then
		state = STATE_NONE
	end

	if state == STATE_RACE then
		timer = timer + dt
		SetFloat("level.track.timer", timer)
	end
		
	if GetBool("level.track.gatebroken") then
		state = STATE_BROKEN
	end
	SetString("level.track.state", state)

	if state == STATE_START then
		SetString("level.track.start", 3-math.floor(startFrame/60))
	else
		SetFloat("level.track.best", bestTime)
		SetFloat("level.track.last", lastTime)
	end
end
