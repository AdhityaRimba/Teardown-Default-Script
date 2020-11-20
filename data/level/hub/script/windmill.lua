function init()
	mainJ = FindJoint("mainjoint")
	propJ = FindJoint("propellerjoint")
	mSpeed = GetFloatParam("mSpeed")
	pSpeed = GetFloatParam("pSpeed")

	SetJointMotor(mainJ,mSpeed,30)
	SetJointMotor(propJ,pSpeed,30)
	change = math.random(5.0,10.0)
	time = 0.0
end

function tick(dt)
	time = time + dt
	if time > change then
		newMVel = math.random(-mSpeed*100,mSpeed*100)/100
		newPVel = math.random(pSpeed*100,pSpeed*200)/100

		SetJointMotor(mainJ,newMVel,30)
		SetJointMotor(propJ,newPVel,30)
		change = time + math.random(5.0,20.0)
	end
end