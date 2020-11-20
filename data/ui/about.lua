function drawAbout()
	if not aboutPos then
		aboutPos = GetLocationTransform(FindLocation("start", true)).pos
		aboutEnd = GetLocationTransform(FindLocation("end", true)).pos
		aboutEndFade = 0
		aboutStartFade = 1
		SetValue("aboutStartFade", 0, "linear", 4)
		aboutInfo = 
		{
			{ image = "menu/logo.png" },
			{ title = "Dennis Gustafsson", info="Programming, game design\nStory and original idea\nLee Chemicals\nBit of everything" },
			{ title = "Emil Bengtsson", info="Missions, level design and assets\nLockelle Hub\nFrustrum village\nBit of everything" },
			{ title = "Kabi Jedhagen", info="West point Marina\nVilla Gordon\nHollowrock Island" },
			{ title = "Douglas Holmquist", info="Music and sound design" },
			{ title = "Niklas Mäckle", info="Assets, vehicles, trees\nCastle create-level" },
			{ title = "Olle Lundahl", info="Evertides Mall\nLevel design, assets" },
			{ title = "Stefan Jonsson", info="Level design, assets" },
			{ title = "Special thanks", info="ephtracy\nMathias Schlegel\nAndreas Baw\nShailesh Prabhu\nLudde Andersson\nSimon Flesser\nDaniel Andersson\nAlex Camilleri\nDeniz Misirli\nJohan Eriksson\nMalmö DevHub" },
			{ title = "Teardown uses", info="libjpeg (libjpeg.sourceforge.net)\nlibpng (libpng.org)\nzlib (zlib.net)\nlua (lua.org)\nogg vorbis (xiph.org/vorbis)\nstb_truetype (github.com/nothings/stb)\nglew (glew.sourceforge.net)\nDear ImGui (github.com/ocornut/imgui)\nLato font by Lukasz Dziedzic (latofonts.com)\nSkyboxes from noemotion.net (CC BY-ND 4.0)\nSkyboxes from hdri-skies.com and hdrihaven.com\n" },
		}
	end

	local dt = GetTimeStep()
	aboutPos[1] = aboutPos[1] + dt * 1.7
	
	if aboutPos[1] > aboutEnd[1] and aboutEndFade == 0 then
		SetValue("aboutEndFade", 1, "linear", 5)
	end
	
	SetCameraTransform(Transform(aboutPos, Quat()), 90)
	PlayMusic("music/about.ogg")
	
	if UiIsKeyPressed("any") or UiIsMousePressed() or aboutEndFade == 1 then
		Command("game.menu")
	end
	
	local locs = FindLocations("txt", true)
	for i=1,#locs do
		local loc = locs[i]
		local pos = GetLocationTransform(loc).pos
		local x,y,d = UiWorldToPixel(pos)
		if x > -500 and x < UiWidth()+500 then
			UiPush()
				UiTranslate(x-100, y)
				UiAlign("left")
				local a = aboutInfo[i]
				if a then
					if a.image then
						UiImage(a.image)
					end
					if a.title and a.info then
						UiFont("font/bold.ttf", 44)
						UiText(a.title)
						UiTranslate(0, 24)
						UiFont("font/regular.ttf", 22)
						UiAlign("left")
						UiColor(.8, .8, .8)
						UiText(a.info, true)
					end
				end
			UiPop()
		end
	end
	
	if aboutEndFade > 0 then
		UiMute(aboutEndFade, true)
		UiColor(0,0,0,aboutEndFade)
		UiRect(UiWidth(), UiHeight())
	end
	if aboutStartFade > 0 then
		UiColor(0,0,0,aboutStartFade)
		UiRect(UiWidth(), UiHeight())
	end
end

