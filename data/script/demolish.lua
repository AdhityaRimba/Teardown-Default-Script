-- Demolish building 
--
-- Tag all bodies part of the building with "demolish"
-- Put trigger around demolition zone and tag with "demolish"
-- Put empty body as target at the desired height level and tag with "target=custom"

#include "common.lua"

pSprite = GetStringParam("sprite", "")
pSpriteSizeX = GetFloatParam("spritex", 7)
pSpriteSizeY = GetFloatParam("spritey", 8)

function init()
	done = false
	trigger = FindTrigger("demolish")
	target = FindBody("target")
	maxHeight = GetBodyTransform(target).pos[2]

	if pSprite ~= "" then
		sprite = LoadSprite(pSprite)
	end
end


function tick(dt)
	if not done then
		if sprite then
			DrawSprite(sprite, GetBodyTransform(target), pSpriteSizeX, pSpriteSizeY, 1, 1, 1, 1, true, false)
		end
		local empty, p = IsTriggerEmpty(trigger, true)
		if not empty and p[2] > maxHeight then
			SetFloat("level.demolish.x", p[1])
			SetFloat("level.demolish.y", p[2])
			SetFloat("level.demolish.z", p[3])
			SetFloat("level.demolish.h", p[2]-maxHeight)
		else
			ClearKey("level.demolish")
			SetString("hud.notification", "Demolition complete")
			done = true
			SetTag(target, "target", "cleared")
		end
	end
end

