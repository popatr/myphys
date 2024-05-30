extends RigidBody2D

@onready var wheel = get_node(^"WalkWheels") as WalkWheels

# Called when the node enters the scene tree for the first time.
func _ready():
	wheel.landed.connect(landed)
	

func landed(time:int, collision:CollisionInfo):
	apply_impulse(collision.impulse)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
var wasOnFloor:bool = false

func _integrate_forces(state):
	
	if(wheel.collisionInfo.count > 1 ):
		linear_velocity = wheel.collisionInfo.velocity1
	
	var onFloor = false
	var groundRelative:Vector2
	for col in get_colliding_bodies():
		onFloor = true
		groundRelative = Vector2.ZERO - linear_velocity
	for col in wheel.customCol():
		onFloor = true
		groundRelative = Vector2.ZERO - linear_velocity
		
	var controlForces:Vector2 = Vector2.ZERO
	var controlTorque = 0
	
	if(onFloor&&!wasOnFloor):
		pass
		
		
	wasOnFloor = onFloor
	if onFloor:
		if Input.is_action_just_pressed("ui_accept"):
			apply_impulse(Vector2(0, -60000))
		else:
			#help give the walkwheel traction
			#controlForces += Vector2(0,1200)
			pass
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if(direction != 0):
		if(onFloor):
			controlTorque += 200000*direction
			#controlForces += Vector2(direction * 30000,0)
		else:
			controlForces += Vector2(direction * 30000,0)
	else: 
		if(onFloor && groundRelative.length() > 0.001):
			#apply_force(groundRelative.normalized() * 2000)
			controlTorque += 20000*groundRelative.normalized().x
			
	apply_force(controlForces)
	wheel.torqueWheels(controlTorque)

