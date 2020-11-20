function init()
	hinge = FindJoint("hinge")
end


function update(dt)
	SetJointMotor(hinge, 1)
end

