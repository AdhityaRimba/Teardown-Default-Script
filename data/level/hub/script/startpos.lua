function init()
	local id = GetString("game.levelid")
	if string.find(id, "hub") then
		local reg = "savegame.hub."..id
		if GetBool(reg) then
			local loc = FindLocation("defaultplayer", true)
			SetPlayerTransform(GetLocationTransform(loc))
		else
			SetBool(reg, true)
		end
	end
end

