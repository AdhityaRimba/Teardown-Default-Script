function init()
end


function draw()
	local a = GetFloat("game.loading.alpha")
	local showText = GetBool("game.loading.text")

	if a < 0 then a = 0 end
	if a > 1 then a = 1 end
	UiColor(0,0,0, a)
	UiRect(UiWidth(), UiHeight())
	
	if showText then
		UiFont("font/regular.ttf", 32)
		UiAlign("center middle")
		UiTranslate(UiCenter(), UiMiddle())
		UiColor(1,1,1,a*a)
		local scale = 1+(1-a)
		UiScale(scale)
		UiText("LOADING")
	end
end

