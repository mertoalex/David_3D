extends StaticBody
var actioning = false
onready var object = $"../../others/ball"

func _process(delta):
	if actioning:
		actioning = false
		object.set("actioning", true)
