extends Button

func _ready():
	connect("button_down", self, "_button_pressed")
	connect("button_up", self, "_button_released")
	
func _button_pressed():
	Input.action_press("back")

func _button_released():
	Input.action_release("back")
