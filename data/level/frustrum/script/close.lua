function init()
	target = FindBody("target")
	pos = GetBodyTransform(target).pos
	done = false
end

function tick(dt)
	if not done then
		local dist = VecLength(VecSub(GetPlayerPos(), pos))
		if dist < 15 then
			SetTag(target, "target", "cleared")
			done = true
		end
	end
end

