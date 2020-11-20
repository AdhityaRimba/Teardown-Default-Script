#include "script/common.lua"

function init()
	turbines = FindBody("turbines")
	bomb = FindBody("largebomb")
	bombshape = FindShape("largebomb")
	beep = LoadSound("LEVEL/script/largetimedbomb/beep")
	trigger = FindTrigger("trigger")
	triggerTransform = GetLocationTransform(FindLocation("trigger"))
	triggerTransform.rot = QuatRotateQuat(triggerTransform.rot, QuatEuler(90, 0, 0))
	rect = LoadSprite("gfx/rect.png")
	bombInPlace = false
	explosionSound = LoadSound("explosion/l0.ogg")
	
	exhausts = FindLocations("exhaust")

	lights = {}
	for i = 1, 5 do
	    lights[i] = FindShapes("light" .. i)
	    for j = 1,#lights[i] do
	    	SetShapeEmissiveScale(lights[i][j], 0)
	    end
	end

	started = false
	timer = 0
	intCounter = 0
	fracCounter = 0
	counter = 10
	exploded = false
	fireTime = 0
end

function rnd(mi, ma)
	return math.random(0, 1000)/1000*(ma-mi)+mi
end

function tick(dt)
	if exploded then
		--Burn for a while
		fireTime = fireTime + dt
		local pos
		if fireTime < 2 and rnd(0.0, 2.0) > fireTime then
			pos = VecAdd(firePos, Vec(rnd(-2,2), 0.0, rnd(-2,2)))
			SpawnParticle("fire", pos, Vec(rnd(-2, 2), rnd(2, 4), rnd(-2, 2)), 2, 3)
			pos = VecAdd(firePos, Vec(rnd(-2,2), 0.0, rnd(-2,2)))
			SpawnParticle("darksmoke", pos, Vec(rnd(-2, 2), rnd(2, 4), rnd(-2,2)), 4, 6)
		end
		if fireTime < 5 and rnd(0.0, 5.0) > fireTime then
			pos = VecAdd(firePos, Vec(rnd(-0.5,0.5), 0.0, rnd(-0.5,0.5)))
			SpawnParticle("fire", pos, Vec(rnd(-0.5, 0.5), rnd(2, 4), rnd(-0.5, 0.5)), 1.0, 0.3)
			pos = VecAdd(firePos, Vec(rnd(-0.5,0.5), 0.0, rnd(-0.5,0.5)))
			SpawnParticle("darksmoke", pos, Vec(0, rnd(3, 5), 0), 1.0, 1)
		end
		return
	end

	timer = timer - dt

	--Check if bomb is in required area
	local b = IsBodyInTrigger(trigger,bomb)
	if not bombInPlace and b then
		SetString("hud.notification", "Bomb in place")
		SetTag(bomb, "interact")
	elseif bombInPlace and not b then
		SetString("hud.notification", "Bomb not in place")
		RemoveTag(bomb, "interact")
	end
	bombInPlace = b

	--Draw sprite if bomb is not in place
	if not bombInPlace then
		local v = math.sin(GetTime()*4)*0.5+0.5
		DrawSprite(rect, triggerTransform, 6.1, 4.1, 1, 1, 1, v, true, false)
	end

	-- Countdown and it's lights
	if started then 
		intCounter = math.ceil(timer/2)
		intCounter = math.clamp(intCounter,0,6)
		fracCounter = (math.floor(((timer/2) % 1) * 2)/2)+0.5

		if(intCounter - 1 + fracCounter ~= counter) and counter > 0 then
			PlaySound(beep, GetBodyTransform(bomb).pos, 0.3)
			counter = intCounter - 1 + fracCounter
			if counter == 0 then
				PlaySound(explosionSound)
				if bombInPlace then
					SetBool("level.alarm",true)
					RemoveTag(turbines, "unbreakable")
					SetTag(turbines, "target", "cleared")
					SetBool("level.tubinesgone", true)
				end
				RemoveTag(bomb, "unbreakable")
				firePos = GetBodyTransform(bomb).pos
				Explosion(firePos, 8, true)
				exploded = true
			end
			--print("int: " .. intCounter .. " | \tfrac: " .. fracCounter .. " | \tcnt: " .. counter)
		end

		if intCounter > 0 then
			for j = 1,#lights[intCounter] do
		    	SetShapeEmissiveScale(lights[intCounter][j], fracCounter)
		    end
		end
		
	    if intCounter < 5 then
	    	for j = 1,#lights[intCounter+1] do
	    	SetShapeEmissiveScale(lights[intCounter+1][j], 0)
	    end
	    end

	end

	if IsBodyInteractable(bomb) then
		DrawBodyOutline(bomb, 1)
		SetString("level.interactinfo", "Detonate")
	end
	if IsBodyOperated(bomb) then
		for i = 1, 5 do
	    for j = 1,#lights[i] do
	    	SetShapeEmissiveScale(lights[i][j], 1)
	    end
	end
		started = true
		timer = 10
		counter = 10
	end
end

