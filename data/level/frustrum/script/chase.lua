#include "script/chopper.lua"

function init()
	cinematic = true
	timer = 0
	done = false
	chopperInit()
	boatSnd = LoadLoop("vehicle/mediumboat-drive.ogg")
end

function cam(name, target)
	local c = FindLocation(name)
	local ct = GetLocationTransform(c)
	local t = FindBody(target)
	local tt = GetBodyTransform(t)
	ct.rot = QuatLookAt(ct.pos, tt.pos)
	SetCameraTransform(ct)
end

function tick(dt)
	if GetBool("game.restarted") then
		done = true
	end
	SetBool("level.endchopper", done)
	SetBool("level.disablequicksave", true)
	if not done then
		if cinematic then
			SetBool("hud.hide", true)
			timer = timer + dt
			local b = FindBody("cutsceneboat")
			local t = GetBodyTransform(b)
			t.pos[1] = t.pos[1] - dt*10
			SetBodyTransform(b, t)
			if timer < 2.5 then
				cam("cam1", "cutsceneboat")
				PlayLoop(boatSnd, t.pos)
			elseif timer < 5 then
				local cb = FindBody("chopper")
				local ct = GetBodyTransform(cb)
				ct.pos[1] = ct.pos[1] - dt*10
				chopperTick(dt, ct.pos, t.pos, t.pos)
				cam("cam2", "chopper")
			else
				cinematic = false
			end
		else
			local v = FindVehicle("playerboat", true)
			local b = GetVehicleBody(v)	
			local t = GetBodyTransform(b)
			local vel = TransformToParentVec(t, Vec(0, 0, -10))
			SetBodyVelocity(b, vel)
			done = true
		end
	end
end

