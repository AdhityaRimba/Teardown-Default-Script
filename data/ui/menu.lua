#include "game.lua"
#include "options.lua"
#include "score.lua"
#include "debug.lua"

bgItems = {nil, nil}
bgCurrent = 0

function bgLoad(i)
	bg = {}
	bg.i = i+1
	bg.t = 0
	bg.x = 0
	bg.y = 0
	bg.vx = 0
	bg.vy = 0
	bg.a = 0
	return bg
end

function bgDraw(bg)
	if bg then
		UiPush()
			local dt = GetTimeStep()
			bg.t = bg.t + dt
			bg.a = math.min(bg.t*0.6, 1.0)
			UiColor(1,1,1,bg.a)
			UiScale(1.03 + bg.t*0.01)
			UiTranslate(bg.x, bg.y)
			UiImage(slideshowImages[bg.i])
		UiPop()
	end
end

bgIndex = 0
bgInterval = 6
bgTimer = bgInterval

function initSlideshow()
	slideshowImages = {}
	for i=1, 5 do
		slideshowImages[#slideshowImages+1] = "menu/hub"..i..".jpg"
	end
	if isLevelUnlocked("lee") then
		for i=1, 3 do
			slideshowImages[#slideshowImages+1] = "menu/lee"..i..".jpg"
		end
	end
	if isLevelUnlocked("marina") then
		for i=1, 7 do
			slideshowImages[#slideshowImages+1] = "menu/marina"..i..".jpg"
		end
	end
	if isLevelUnlocked("mansion") then
		for i=1, 6 do
			slideshowImages[#slideshowImages+1] = "menu/mansion"..i..".jpg"
		end
	end
	if isLevelUnlocked("caveisland") then
		for i=1, 5 do
			slideshowImages[#slideshowImages+1] = "menu/caveisland"..i..".jpg"
		end
	end

	--Scramble order
	for i=1, #slideshowImages do
		local j = math.random(1, #slideshowImages)
		local tmp = slideshowImages[j]
		slideshowImages[j] = slideshowImages[i]
		slideshowImages[i] = tmp
	end
end

function init()
	initSlideshow()

	gOptionsScale = 0
	gSandboxScale = 0
	gPlayScale = 0

	gCreateScale = 0

	bgItems[bgCurrent] = bgLoad(bgIndex)
	gDeploy = GetBool("game.deploy")
end


function isLevelUnlocked(level)
	local missions = ListKeys("savegame.mission")
	local levelMissions = {}
	for i=1,#missions do
		local missionId = missions[i]
		if gMissions[missionId] and GetBool("savegame.mission."..missionId) then
			if gMissions[missionId].level == level then
				return true
			end
		end
	end
	return false
end


function drawSandbox(scale)
	local open = true
	UiPush()
		local w = 800
		local h = 400
		UiTranslate(UiCenter(), UiMiddle())
		UiScale(scale)
		UiColorFilter(1, 1, 1, scale)
		UiColor(0,0,0, 0.5)
		UiAlign("center middle")
		UiImageBox("common/box-solid-shadow-50.png", w, h, -50, -50)
		UiWindow(w, h)
		UiAlign("left top")
		UiColor(1,1,1)
		if UiIsKeyPressed("esc") or (not UiIsMouseInRect(UiWidth(), UiHeight()) and UiIsMousePressed()) then
			open = false
		end

		UiPush()
			UiFont("font/bold.ttf", 48)
			UiColor(1,1,1)
			UiAlign("center")
			UiTranslate(UiCenter(), 80)
			UiText("SANDBOX")
		UiPop()
		
		UiPush()
			UiFont("font/regular.ttf", 22)
			UiTranslate(200, 90)
			UiWordWrap(420)
			UiColor(0.8, 0.8, 0.8)
			UiText("Free roam sandbox play with unlimited resources and no challenge. Play the campaign to unlock more environments and tools.")
		UiPop()
	
		UiTranslate(10 + UiWidth()/2-(150*#gSandbox)/2, 190)
		UiFont("font/bold.ttf", 22)
		for i=1, #gSandbox do
			UiPush()
				local locked = not isLevelUnlocked(gSandbox[i].level)
				UiPush()
					if locked then
						UiDisableInput()
						UiColorFilter(.5, .5, .5)
					end
					if UiImageButton(gSandbox[i].image) then
						Command("game.startmission", gSandbox[i].id, gSandbox[i].file, gSandbox[i].layers)
					end
				UiPop()
				if locked then
					UiPush()
						UiTranslate(64, 64)
						UiAlign("center middle")
						UiImage("menu/locked.png")
					UiPop()
					if UiIsMouseInRect(128, 128) then
						UiPush()
							UiAlign("center middle")
							UiTranslate(64,  180)
							UiFont("font/regular.ttf", 20)
							UiColor(.8, .8, .8)
							UiText("Unlocked in\ncampaign")
						UiPop()
					end
				end

				UiAlign("center")
				UiTranslate(64, 150)
				UiColor(0.8, 0.8, 0.8)
				UiText(gSandbox[i].name)
			UiPop()
			UiTranslate(150, 0)
		end
	UiPop()
	return open
end



function drawCreate(scale)
	local open = true
	UiPush()
		local w = 800
		local h = 530
		UiTranslate(UiCenter(), UiMiddle())
		UiScale(scale)
		UiColorFilter(1, 1, 1, scale)
		UiColor(0,0,0, 0.5)
		UiAlign("center middle")
		UiImageBox("common/box-solid-shadow-50.png", w, h, -50, -50)
		UiWindow(w, h)
		UiAlign("left top")
		UiColor(1,1,1)
		if UiIsKeyPressed("esc") or (not UiIsMouseInRect(UiWidth(), UiHeight()) and UiIsMousePressed()) then
			open = false
		end

		UiPush()
			UiFont("font/bold.ttf", 48)
			UiColor(1,1,1)
			UiAlign("center")
			UiTranslate(UiCenter(), 60)
			UiText("CREATE")
		UiPop()
		
		UiPush()
			UiFont("font/regular.ttf", 22)
			UiTranslate(UiCenter(), 100)
			UiAlign("center")
			UiWordWrap(600)
			UiColor(0.8, 0.8, 0.8)
			UiText("Create your own sandbox level using the free voxel modeling program MagicaVoxel. We have provided example levels that you can modify or replace with your own creation. Find out more on our web page:", true)
			UiTranslate(0, 2)
			UiFont("font/bold.ttf", 22)
			UiColor(1, .8, .5)
			if UiTextButton("www.teardowngame.com/create") then
				Command("game.openurl", "http://www.teardowngame.com/create")
			end

			UiTranslate(0, 70)
			UiPush()
				UiColor(1,1,1)
				UiFont("font/regular.ttf", 26)
				UiButtonImageBox("common/box-outline-6.png", 6, 6, 1, 1, 1)
				if UiTextButton("Basic level", 240, 40) then
					Command("game.startlevel", "../../create/basic.xml")
				end
				UiTranslate(0, 45)
				if UiTextButton("Island level", 240, 40) then
					Command("game.startlevel", "../../create/island.xml")
				end
				UiTranslate(0, 45)
				if UiTextButton("Castle level", 240, 40) then
					Command("game.startlevel", "../../create/castle.xml")
				end
				UiTranslate(0, 45)
				if UiTextButton("Vehicle level", 240, 40) then
					Command("game.startlevel", "../../create/vehicle.xml")
				end
				UiTranslate(0, 45)
				if UiTextButton("Custom level", 240, 40) then
					Command("game.startlevel", "../../create/custom.xml")
				end
			UiPop()

			UiTranslate(0, 250)
			UiFont("font/regular.ttf", 20)
			UiColor(.6, .6, .6)
			UiText("Files located at: " .. GetString("game.path") .. "/create")
		UiPop()
	UiPop()
	return open
end


function mainMenu()
	UiPush()
		UiColor(0,0,0, 0.75)
		UiRect(UiWidth(), 150)
		UiColor(1,1,1)
		UiPush()
			UiTranslate(50, 20)
			UiScale(0.8)
			UiImage("menu/logo.png")
		UiPop()
		UiFont("font/regular.ttf", 36)
		UiTranslate(800, 30)
		UiTranslate(0, 50)
		UiAlign("center middle")
		UiPush()
			UiButtonImageBox("common/box-outline-6.png", 6, 6, 1, 1, 1)

			local bh = 50
			local bo = 56

			UiPush()
				if UiTextButton("Play", 250, bh) then
					UiSound("common/click.ogg")
					if gPlayScale == 0 then
						SetValue("gPlayScale", 1.0, "easeout", 0.25)
					else
						SetValue("gPlayScale", 0.0, "easein", 0.25)
					end
				end
			UiPop()

			UiTranslate(300, 0)

			UiPush()
				if UiTextButton("Options", 250, bh) then
					UiSound("common/click.ogg")
					SetValue("gOptionsScale", 1.0, "easeout", 0.25)
					SetValue("gPlayScale", 0.0, "easein", 0.25)
				end
			UiPop()

			UiTranslate(300, 0)

			UiPush()
				if UiTextButton("About", 250, bh) then
					UiSound("common/click.ogg")
					Command("game.startmission", "about", "about.xml")
					SetValue("gPlayScale", 0.0, "easein", 0.25)
				end
			UiPop()
				
			UiTranslate(300, 0)

			UiPush()
				if UiTextButton("Quit", 250, bh) then
					UiSound("common/click.ogg")
					Command("game.quit")
					SetValue("gPlayScale", 0.0, "easein", 0.25)
				end
			UiPop()
		UiPop()
	UiPop()

	if gPlayScale > 0 then
		local bw = 200
		local bh = 40
		local bo = 48
		UiPush()
			UiTranslate(672, 160)
			UiScale(1, gPlayScale)
			UiColorFilter(1,1,1,gPlayScale)
			if gPlayScale < 0.5 then
				UiColorFilter(1,1,1,gPlayScale*2)
			end
			UiColor(0,0,0,0.75)
			UiFont("font/regular.ttf", 26)
			UiImageBox("common/box-solid-10.png", 260, 210, 10, 10)
			UiColor(1,1,1)
			UiButtonImageBox("common/box-outline-6.png", 6, 6, 1, 1, 1)
			UiAlign("top left")
			UiTranslate(25, 25)

			if UiTextButton("Campaign", bw, bh) then
				UiSound("common/click.ogg")
				startHub()
			end	
			UiTranslate(0, bo)

			if UiTextButton("Sandbox", bw, bh) then
				UiSound("common/click.ogg")
				SetValue("gSandboxScale", 1, "cosine", 0.25)
			end			
			UiTranslate(0, bo)

			UiTranslate(0, 20)
			if UiTextButton("Create", bw, bh) then
				UiSound("common/click.ogg")
				SetValue("gCreateScale", 1, "cosine", 0.25)
			end			
		UiPop()
	end
	if gSandboxScale > 0 then
		UiPush()
			UiBlur(gSandboxScale)
			UiColor(0.7,0.7,0.7, 0.25*gSandboxScale)
			UiRect(UiWidth(), UiHeight())
			UiModalBegin()
			if not drawSandbox(gSandboxScale) then
				SetValue("gSandboxScale", 0, "cosine", 0.25)
			end
			UiModalEnd()
		UiPop()
	end
	if gCreateScale > 0 then
		UiPush()
			UiBlur(gCreateScale)
			UiColor(0.7,0.7,0.7, 0.25*gCreateScale)
			UiRect(UiWidth(), UiHeight())
			UiModalBegin()
			if not drawCreate(gCreateScale) then
				SetValue("gCreateScale", 0, "cosine", 0.25)
			end
			UiModalEnd()
		UiPop()
	end
	if gOptionsScale > 0 then
		UiPush()
			UiBlur(gOptionsScale)
			UiColor(0.7,0.7,0.7, 0.25*gOptionsScale)
			UiRect(UiWidth(), UiHeight())
			UiModalBegin()
			if not drawOptions(gOptionsScale, true) then
				SetValue("gOptionsScale", 0, "cosine", 0.25)
			end
			UiModalEnd()
		UiPop()
	end
end


function tick()
	if GetTime() > 0.1 then
		PlayMusic("music/menu.ogg")
	end
end


function drawBackground()
	UiPush()
		if bgTimer >= 0 then
			bgTimer = bgTimer - GetTimeStep()
			if bgTimer < 0 then
				old = bgIndex
				while bgIndex == old do
					bgIndex = math.mod(bgIndex+1, #slideshowImages-1)
				end
				bgTimer = bgInterval

				bgCurrent = 1-bgCurrent
				bgItems[bgCurrent] = bgLoad(bgIndex)
			end
		end

		UiTranslate(UiCenter(), UiMiddle())
		UiAlign("center middle")
		bgDraw(bgItems[1-bgCurrent])
		bgDraw(bgItems[bgCurrent])
	UiPop()
end


function draw()
	UiButtonHoverColor(0.8,0.8,0.8,1)

	UiPush()
		--Create a safe 1920x1080 window that will always be visible on screen
		local x0,y0,x1,y1 = UiSafeMargins()
		UiTranslate(x0,y0)
		UiWindow(x1-x0,y1-y0, true)

		drawBackground()
		mainMenu()
		
	UiPop()

	if not gDeploy and mainMenuDebug then
		mainMenuDebug()
	end

	UiPush()
		UiTranslate(UiWidth()-50, UiHeight()-10)
		UiFont("font/regular.ttf", 18)
		UiColor(1,1,1,0.3)
		UiText(GetString("game.version"))
	UiPop()

	if GetBool("game.saveerror") then
		UiPush()
			UiFont("font/bold.ttf", 26)
			UiTextOutline(0, 0, 0, 1, 0.1)
			UiColor(1,.5,.5)
			UiAlign("center")
			UiTranslate(UiCenter(), UiHeight()-200)
			UiWordWrap(800)
			UiText("WARNING! Game failed to save progress and will not function correctly.\n\nThis may be caused by Windows Defender or other security software blocking access to Documents/Teardown in your home folder. Please see homepage FAQ for further details: http://teardowngame.com")
		UiPop()
	end
end


function handleCommand(cmd)
	if cmd == "resolutionchanged" then
		gOptionsScale = 1
		optionsTab = "display"
	end
	if cmd == "activate" then
		initSlideshow()
		bgTimer = bgInterval
	end
end

