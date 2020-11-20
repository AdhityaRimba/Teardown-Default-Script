function init()
	count = 4
	current = 0
	t = 0
end

function draw()
	UiTranslate(UiCenter(), UiMiddle())
	UiAlign("center middle")
	local a = current
	local b = math.mod(current+1, count)
	t = t + GetTimeStep()
	UiImage("tv/img"..(a+1)..".jpg")
	if t > 4 then
		UiScale(t-4)
		UiImage("tv/img"..(b+1)..".jpg")
	end
	if t > 5 then
		t = 0
		current = b
	end
end
