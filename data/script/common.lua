function clamp(value, mi, ma)
	if value < mi then value = mi end
	if value > ma then value = ma end
	return value
end

function trim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function splitString(str, delimiter)
	local result = {}
	for word in string.gmatch(str, '([^'..delimiter..']+)') do
		result[#result+1] = trim(word)
	end
	return result
end

function outlineInteractableShape(shape, d)
	d = d or 8
	local dist = VecLength(VecSub(GetPlayerPos(), GetShapeWorldTransform(shape).pos))
	if dist < d and IsShapeSeenByPlayer(shape) then
		DrawShapeOutline(shape, 1-dist/d)
	end
end

function outlineInteractableBody(body, d)
	d = d or 8
	local dist = VecLength(VecSub(GetPlayerPos(), GetBodyTransform(body).pos))
	if dist < d and IsBodySeenByPlayer(body) then
		DrawBodyOutline(body, 1-dist/d)
	end
end

function smoothstep(edge0, edge1, x)
	x = math.clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
	return x * x * (3 - 2 * x)
end

function math.clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end
