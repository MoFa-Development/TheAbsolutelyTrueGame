extends RigidBody
class_name RigidObject


onready var initial_transform = global_transform
onready var initial_rotation = rotation


var resettingPos = false setget set_resetting


func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "timeout")
	timer.one_shot = false
	timer.start(5.0)

func _process(delta):
	if resettingPos:
		if _pos().distance_to(initial_transform.origin) < 0.2 && rotation.distance_to(initial_rotation) < 1:
			resettingPos = false
		resetPos()

func resetPos():
	pass
	# linear_velocity = lerp(Vector3.ZERO, _pos().direction_to(initial_transform), 0.01) Bringt alles zum fliegen wtf
	
	# global_transform.origin = lerp(_pos(), initial_transform.origin, 0.01)
	# rotation = lerp(rotation, initial_rotation, 0.5)
	
	# global_transform.origin = initial_transform.origin
	# rotation = initial_rotation

func timeout():
	if _pos().distance_to(initial_transform.origin) > 1:
		resettingPos = true


func _pos() -> Vector3:
	return global_transform.origin

func set_resetting(val):
	resettingPos = val
	if resettingPos:
		for child in get_children():
			if child is CollisionShape:
				child.disabled = false
	else:
		for child in get_children():
			if child is CollisionShape:
				child.disabled = true
