class_name Wheel
extends RigidBody2D

var lvo: Vector2 = Vector2.ZERO
var minDelta = 10
var collisionInfo = CollisionInfo.new()
	
func _integrate_forces(state):
	collisionInfo.deltaV = lvo - state.linear_velocity
	collisionInfo.velocity1 = state.linear_velocity
	collisionInfo.count = get_contact_count()
	if(collisionInfo.count == 0):
		collisionInfo.velocity2 = Vector2.ZERO
		collisionInfo.normal = Vector2.ZERO
		collisionInfo.impulse = Vector2.ZERO
	else:
		collisionInfo.normal = state.get_contact_local_normal(0)
		collisionInfo.impulse = state.get_contact_impulse(0)
		collisionInfo.velocity2 = state.get_contact_collider_velocity_at_position(0)
		if(collisionInfo.impulse > Vector2.ZERO):
			linear_velocity = Vector2.ZERO
			
	lvo = state.linear_velocity
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
