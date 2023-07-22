extends RigidBody

func _ready():
	set_max_contacts_reported(1)

func _process(delta):
	for collider in get_colliding_bodies():
		if collider.is_in_group("restart"): set_translation(Vector3(17.5,25,0))
