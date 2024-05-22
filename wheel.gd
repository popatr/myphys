class_name Wheel
extends RigidBody2D

var contact:bool = false
var smoothedCol:SmoothedCollision = SmoothedCollision.new()
var iter=0

func _integrate_forces(state):
	var contacts = get_contact_count()
	var collision = CollisionInfo.new()
	collision.count=contacts
	collision.velocity1 = linear_velocity
	if(collision.collided()):
		collision.normal = state.get_contact_local_normal(0)
		collision.velocity2 = state.get_contact_collider_velocity_at_position(0)
		collision.what = state.get_contact_collider_object(0)
		collision.force = state.get_contact_impulse(0)
		
	smoothedCol.addCollision(collision)
	var contactNow = smoothedCol.smoothedCollision.collided();
	
	if(contact!=contactNow):
		contact = contactNow
		if(contactNow):
			#first contact
			iter+=1
		else:
			#first air
			iter+=1      
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
