class_name Wheel
extends RigidBody2D

signal gotAir(who:Wheel, time:int)
signal landed(who:Wheel, time:int, collision:CollisionInfo)
var isLanded:bool

var contact:bool = false
var smoothedCol:SmoothedCollision = SmoothedCollision.new()
var iter=0
var lvo: Vector2 = Vector2.ZERO

func _integrate_forces(state):
	var contacts = get_contact_count()
	var collision = CollisionInfo.new()
	collision.count=contacts
	collision.velocity1 = linear_velocity
	if(collision.collided()):
		collision.normal = state.get_contact_local_normal(0)
		collision.velocity2 = state.get_contact_collider_velocity_at_position(0)
		collision.what = state.get_contact_collider_object(0)
		collision.deltaV = lvo-state.linear_velocity
		
	smoothedCol.addCollision(collision)
	var contactNow = smoothedCol.smoothedCollision.collided();
	
	if(contact!=contactNow):
		contact = contactNow
		if(contactNow):
			#first contact
			isLanded = true
			landed.emit(self, 0, smoothedCol)
			iter+=1
			if(iter > 15):
				iter=0
				
		else:
			#first air
			isLanded=false
			gotAir.emit(self, 0)
			iter+=1
			
	lvo = state.linear_velocity
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
