function draw()
	local i = math.floor(GetTime())%8
	if i== 1 then
		UiColor(1,0,0)
		UiRect(640, 480)
	end
	if i== 2 then
		UiColor(0,1,0)
		UiRect(640, 480)
	end
	if i== 3 then
		UiColor(0,0,1)
		UiRect(640, 480)
	end
	if i== 5 then
		UiColor(1,1,0)
		UiRect(320, 480)
		UiTranslate(320, 0)
		UiColor(0,1,1)
		UiRect(320, 480)
	end
	if i== 6 then
		UiColor(1,0,1)
		UiRect(320, 480)
		UiTranslate(320, 0)
		UiColor(1,1,0)
		UiRect(320, 480)
	end
	if i== 7 then
		UiColor(0,0,0)
		UiRect(320, 480)
		UiTranslate(320, 0)
		UiColor(1,1,1)
		UiRect(320, 480)
	end
end

