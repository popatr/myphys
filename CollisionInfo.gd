extends Object
class_name CollisionInfo

var collisionThreshold = 0.01
var count:float = 0
var normal:Vector2 = Vector2.ZERO
var deltaV:Vector2 = Vector2.ZERO
var velocity1:Vector2 = Vector2.ZERO
var velocity2:Vector2 = Vector2.ZERO
var what:Node2D = null

func collided()->bool:
	return count>collisionThreshold
	
func relativeVelocity()->Vector2:
	return velocity1 - velocity2
