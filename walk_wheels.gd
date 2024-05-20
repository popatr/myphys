class_name WalkWheels
extends RigidBody2D

@onready var wheels:Array[Wheel] = getWheels(self)

#call in a physics loop
func torqueWheels(torque):
	for wheel in wheels:
		wheel.apply_torque(torque)

func getWheels(parent:Node2D):
	var wlist:Array[Wheel] = []
	for child in parent.get_children():
		if(child is Wheel):
			wlist.append(child)
		else:
			wlist.append_array(getWheels(child))
	return wlist
		
		
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
