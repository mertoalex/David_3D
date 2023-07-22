extends Area
var render = true
onready var label = $"../you like playing with balls, don't you ?"

func _process(delta):
	for collider in get_overlapping_bodies():
		if collider.is_in_group("ball"): label.set_visible(true)
		else: label.set_visible(false)
