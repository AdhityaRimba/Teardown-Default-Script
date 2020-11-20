function init()
	t = 0
	showLogo = 0
	showText = 0
	done = false
	splashTime = 20
	requiredTime = 4
end


function tick()
	t = t + GetTimeStep()
	if t > splashTime or (t > requiredTime and (UiIsMousePressed() or UiIsKeyPressed("any"))) then
		if not done then
			Command("game.menu")
			done = true
		end
	end
end


function draw()
	if t < 4.0 then
		UiPush()
			if t > 0.5 and showLogo==0 then
				SetValue("showLogo", 1, "easeout", 1.0)
				UiSound("splash/zoom.ogg")
			end

			if t > 1.7 and showText==0 then
				SetValue("showText", 1, "bounce", 0.5)
				UiSound("splash/plop.ogg")
			end

			UiColor(1,1,1)
			UiRect(UiWidth(), UiHeight())

			UiAlign("center middle")
			UiTranslate(UiCenter(), UiMiddle())

			UiPush()
				UiTranslate(0, -50*showText)
				UiScale(showLogo)
				UiRotate((1-showLogo)*40)
				UiColor(1,1,1,showLogo)
				UiImage("splash/logo.png")
			UiPop()
	
			UiTranslate(0, 80)
			UiScale(1, showText)
			UiImage("splash/tuxedolabs.png")
		UiPop()
	else
		UiPush()
			UiColor(0,0,0)
			UiRect(UiWidth(), UiHeight())
			
			UiTranslate(UiCenter(), UiMiddle()-150)
			UiAlign("center")
			UiFont("font/bold.ttf", 24)
			UiPush()
				UiScale(2)
				UiColor(1,.2,.2)
				UiText("WARNING")
			UiPop()
			UiTranslate(0, 40)
			UiColor(.8, .8, .8)
			UiWordWrap(500)
			UiText("This game contains flashing lights that may trigger seizures for people with photosensitive epilepsy.", true)

			UiTranslate(0, 50)
			UiColor(1, 1, 1)
			UiText("Teardown is a work of fiction and is intended for entertainment purposes only. We do not encourage any form of vandalism, theft, reckless driving, illegal activities or irresponsible behavior in the real world.", true)

			UiTranslate(0, 50)
			UiColor(.8, .8, .8)
			UiText("Press any key to continue", true)
			UiText("Copyright 2020 Tuxedo Labs AB", true)

		UiPop()
	end
end

