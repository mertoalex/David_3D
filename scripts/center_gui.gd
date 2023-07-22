extends Sprite

onready var display = $".."

func _process(delta):
	set_position(Vector2(display.rect_size.x/2,display.rect_size.y/2))
