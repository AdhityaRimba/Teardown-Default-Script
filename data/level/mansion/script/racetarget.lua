pTime = GetFloatParam("time", 30)

function init()
	target = FindBody("target")
	done = false
end

function tick(dt)
	if not done then
		local last = GetFloat("level.track.last")
		if last > 0.0 and last < pTime then
			SetTag(target, "target", "cleared")
			done = true
		end
	end
end
