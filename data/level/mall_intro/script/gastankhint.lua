function init()
	shapes = FindShapes("explosive")
	trigger = FindTrigger("hint")
	hintarea = FindTrigger("hintarea")
	location = FindLocation("hint")
	intact = true
	arrow = LoadSprite("gfx/arrowdown.png")
	fireHint = false
end

function drawArrow(location)
	local t = GetLocationTransform(location)
	t.rot = QuatLookAt(t.pos, GetCameraTransform().pos)
	local offset = 1.5 + math.sin(4.0*GetTime())*0.5
	t.pos[2] = t.pos[2] + offset
	DrawSprite(arrow, t, 1.3, 1.3, .3, .3, .3, 3, false, true)
	DrawSprite(arrow, t, 1.3, 1.3, 1, 1, 1, 1, true, true)
end

function tick(dt)
	if not GetBool("level.complete") then
		if not GetBool("hud.hasnotification") then
			local fc = GetFireCount()
			if not fireHint and fc > 20 then fireHint = true end
			if fireHint and fc < 10 then fireHint = false end

			if fireHint then
				SetString("hud.hintinfo", "Use your extinguisher to put out fires")
			else
				for i=1, #shapes do
					if not IsHandleValid(shapes[i]) then
						done = true
					end
					if not IsShapeInTrigger(trigger, shapes[i]) then
						intact = false
					end
				end
				if IsPointInTrigger(hintarea, GetPlayerPos()) and not GetBool("game.player.usevehicle") then
					if intact and GetTime() > 25 then
						if not IsPointInTrigger(trigger, GetPlayerPos()) then
							drawArrow(location)
						end
						SetString("hud.hintinfo", "Propane tanks explode when thrown")
					end
				end
				
				local g = GetPlayerGrabShape()
				if g ~= 0 and HasTag(g, "explosive") then
					SetString("hud.hintimage", "ui/hud/tutorial/throw.png")
				end
			end
		end
	end
end
