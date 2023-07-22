extends RigidBody
var actioning = false

func _process(delta):
	if actioning:
		actioning = false
		set_visible(true)
		set_translation(Vector3(0,14,0))
		set_sleeping(false)
