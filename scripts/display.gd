extends Control
var window_size = Vector2()
func _process(delta):
	window_size = OS.get_window_size()
	margin_right = window_size.x
	margin_bottom = window_size.y
