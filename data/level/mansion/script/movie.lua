function init()
	t = 0
end

function draw()
	t = t + GetTimeStep()
	if t > 45 then t = 0 end

	UiColor(.1, 0.08, 0.06)
	UiRect(UiWidth(), UiHeight())

	UiTranslate(UiCenter(), 500-t*40)
	
	UiColor(1,1,1)

	UiAlign("center")

	UiFont("ui/font/bold.ttf", 36)
	UiText("Dennis Gustafsson")
	UiTranslate(0, 24)
	UiFont("ui/font/regular.ttf", 24)
	UiText("Programming, game design", true)
	UiText("Story and original idea", true)
	UiText("Lee Chemicals", true)
	UiText("Bit of everything", true)
	UiTranslate(0, 100)

	UiFont("ui/font/bold.ttf", 36)
	UiText("Emil Bengtsson")
	UiTranslate(0, 24)
	UiFont("ui/font/regular.ttf", 24)
	UiText("Missions, level design and assets", true)
	UiText("Löckelle hub", true)
	UiText("Frustrum village", true)
	UiText("Bit of everything", true)
	UiTranslate(0, 100)

	UiFont("ui/font/bold.ttf", 36)
	UiText("Kabi Jedhagen")
	UiTranslate(0, 24)
	UiFont("ui/font/regular.ttf", 24)
	UiText("West point Marina", true)
	UiText("Villa Gordon", true)
	UiText("Hollowrock Island", true)
	UiTranslate(0, 100)

	UiFont("ui/font/bold.ttf", 36)
	UiText("Douglas Holmquist")
	UiTranslate(0, 24)
	UiFont("ui/font/regular.ttf", 24)
	UiText("Music and sound design", true)
	UiTranslate(0, 100)

	UiFont("ui/font/bold.ttf", 36)
	UiText("Niklas Mäckle")
	UiTranslate(0, 24)
	UiFont("ui/font/regular.ttf", 24)
	UiText("Assets, vehicles, trees", true)
	UiTranslate(0, 100)

	UiFont("ui/font/bold.ttf", 36)
	UiText("Olle Lundahl")
	UiTranslate(0, 24)
	UiFont("ui/font/regular.ttf", 24)
	UiText("Evertides mall", true)
	UiText("Level design, assets", true)
	UiTranslate(0, 100)

	UiFont("ui/font/bold.ttf", 36)
	UiText("Stefan Jonsson")
	UiTranslate(0, 24)
	UiFont("ui/font/regular.ttf", 24)
	UiText("Level design, assets", true)
	UiTranslate(0, 100)
end

