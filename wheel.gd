class_name Wheel
extends RigidBody2D

var colnorm:Vector2
var contactHistory:Array[int] = [0,0,0]
var contactVel:Vector2
var lvOld:Vector2

func _integrate_forces(state):
	var contacts = get_contact_count()
	contactHistory.push_front(contacts>0)
	var contactNow = contactHistory.sum
		if(contact):
			contactVel = lvOld
			contactVel -= state.get_contact_collider_velocity_at_position(0)
			contactVel += Vector2.ZERO
	if contacts>0:
		colnorm = state.get_contact_local_normal(0)
		colnorm += Vector2.ZERO
		
	
	lvOld = state.linear_velocity
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
