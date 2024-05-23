class_name WalkWheels
extends RigidBody2D

@onready var wheels:Array[Wheel] = getWheels(self)

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
			child.connect("landed", wheelLanded)
			child.connect("gotAir", wheelAir)
		else:
			wlist.append_array(getWheels(child))
	return wlist
		
		
var smoothedCollision = SmoothedCollision.new()  #todo: make sure the size matches the number of wheels
func wheelLanded(who:Wheel, time:int, collision:CollisionInfo) -> void:
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
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_wheel_landed(who, time, collision):
	pass # Replace with function body.
