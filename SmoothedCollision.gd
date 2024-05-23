extends Object
class_name SmoothedCollision

var smoothedCollision:CollisionInfo = CollisionInfo.new()
var count = 3;
var collisions:Array[CollisionInfo] = []

func _init():
	for i in count:
		collisions.push_front(CollisionInfo.new())

func addCollision(col:CollisionInfo)->CollisionInfo:
	var losingCol = collisions.pop_back()
	collisions.push_front(col)
	smoothedCollision.count += (col.count - losingCol.count)/count
	smoothedCollision.normal += (col.normal -losingCol.normal) / 3
	if(col.count>0.01):
		smoothedCollision.what = col.what
	if(smoothedCollision.count < 0.01):
		smoothedCollision.velocity1 = col.velocity1
		smoothedCollision.velocity2 = Vector2.ZERO
		smoothedCollision.deltaV = Vector2.ZERO
		smoothedCollision.what = null
	else:
		smoothedCollision.velocity1 = smoothedCollision.velocity1 if(smoothedCollision.velocity1 > col.velocity1) else col.velocity1
		smoothedCollision.velocity2 = smoothedCollision.velocity2 if(smoothedCollision.velocity2 > col.velocity2) else col.velocity2
		smoothedCollision.deltaV = smoothedCollision.deltaV if(smoothedCollision.deltaV > col.deltaV) else col.deltaV
	return smoothedCollision
		
	
