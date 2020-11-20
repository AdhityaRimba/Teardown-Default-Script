function init()
	exhausts = FindLocations("exhaust")
	cracks = FindLocations("crack")
	turbines = LoadLoop("LEVEL/script/dam/turbines.ogg")
	water = LoadLoop("LEVEL/script/dam/water.ogg")
	sndPos = GetLocationTransform(FindLocation("watersound")).pos
end

function rnd(mi, ma)
	return math.random(0, 1000)/1000*(ma-mi)+mi
end

function tick(dt)
	if GetBool("level.tubinesgone") then
		for i=1, #cracks do
			local t = GetLocationTransform(cracks[i])
			local dir = TransformToParentVec(t, Vec(rnd(-0.1, 0.1), rnd(-0.1, 0.1), 1))
			local r = GetTagValue(cracks[i], "crack")
			SpawnParticle("water", t.pos, VecScale(dir, 5+10*r), r, 2)
		end
		PlayLoop(water, sndPos)
	else
		for i=1, #exhausts do
			local t = GetLocationTransform(exhausts[i])
			local dir = TransformToParentVec(t, Vec(rnd(-0.1, 0.1), rnd(-0.1, 0.0), 1))
			SpawnParticle("water", t.pos, VecScale(dir, 7), 0.3, 2)
		end
		PlayLoop(turbines, sndPos, 0.3)
	end
end

