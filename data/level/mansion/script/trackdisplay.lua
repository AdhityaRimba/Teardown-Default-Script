function draw()
	UiFont("ui/font/bold.ttf", 48)
	UiAlign("center middle")
	UiTranslate(UiCenter(), UiMiddle())
	UiColor(1,1,1)
	local state = GetString("level.track.state")
	local timer = math.floor(GetFloat("level.track.timer") * 100) / 100
	local bestTime = math.floor(GetFloat("level.track.best") * 100) / 100
	local lastTime = math.floor(GetFloat("level.track.last") * 100) / 100
	if state == "ready" then
		UiPush()
			UiScale(2)
			UiText("GET READY")
		UiPop()
	elseif state == "broken" then
		UiPush()
			UiScale(2)
			UiText("GATE BROKEN")
		UiPop()
	elseif state == "start" then
		UiPush()
			UiScale(4)
			UiText(GetString("level.track.start"))
		UiPop()
	elseif state == "race" then
		UiPush()
			UiScale(4)
			UiAlign("left middle")
			UiTranslate(-50, 0)
			UiText(timer)
		UiPop()
	elseif state == "finish" then
		UiPush()
			UiScale(2)
			UiText("LAP TIME", true)
			lastTime = timer
			UiText(timer)
		UiPop()
	else
		UiPush()
			UiScale(1.5)
			UiAlign("top left")
			UiTranslate(-200, -50)
			if lastTime > 0 then
				UiText("LAST LAP     "..lastTime)
			end
			UiTranslate(0, 50)
			UiText("TRACK RECORD "..bestTime)
		UiPop()
	end
end
