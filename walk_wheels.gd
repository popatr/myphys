class_name WalkWheels
extends RigidBody2D

var wheels:Array[Wheel] = []
var wheelCount:int = 0
signal gotAir(time)
signal landed(time, collision)

#call in a physics loop
func torqueWheels(torque):
	for wheel in wheels:
		wheel.apply_torque(torque)

func getWheels(parent:Node2D):
	var wlist:Array[Wheel] = []
	for child in parent.get_children():
		if(child is Wheel):
			wlist.append(child)
			#child.gotAir.connect(wheelAir)
			#child.hitSomething.connect(wheelLanded)
		else:
			wlist.append_array(getWheels(child))
	return wlist
		
		
var smoothedCollision = SmoothedCollision.new()  #todo: make sure the size matches the number of wheels

func wheelLanded(who:Wheel, time:int, collision:CollisionInfo):
	smoothedCollision.addCollision(collision)
	landed.emit(time, smoothedCollision.smoothedCollision)
	
func wheelAir(wheel:Wheel, time:int):
	if(wheels.all(hasAir)):
		smoothedCollision = SmoothedCollision.new()
		gotAir.emit(time)
		
func hasAir(wheel:Wheel):
	return !wheel.isLanded
	
func customCol():
	for wheel in wheels:
		var col= wheel.get_colliding_bodies()
		if(col!=null && col.size() > 0 ):
			return col
	return []	
	
var lvo:Vector2 = Vector2.ZERO
var isLanded:bool = false
var collisionInfo:CollisionInfo = CollisionInfo.new()
func _integrate_forces(state):
	collisionInfo = CollisionInfo.new()
	for wheel in wheels:
		collisionInfo.count += wheel.collisionInfo.count
		collisionInfo.deltaV += wheel.collisionInfo.deltaV / wheelCount
		collisionInfo.impulse += wheel.collisionInfo.impulse / wheelCount
		collisionInfo.normal += wheel.collisionInfo.normal / wheelCount
		collisionInfo.velocity1 += wheel.collisionInfo.velocity1 / wheelCount
		collisionInfo.velocity2 += wheel.collisionInfo.velocity2 / wheelCount
		collisionInfo.what = wheel.collisionInfo.what
	
	linear_velocity = collisionInfo.velocity1
	
	
	
		
	lvo = state.linear_velocity
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	wheels = getWheels(self)
	wheelCount = wheels.size()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
