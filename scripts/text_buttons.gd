extends RichTextLabel
var level1 = preload("res://scenes/level1.tscn")

onready var display = $".."

func _ready():
	#bbcode_enabled = true
	#bbcode_text = "[url=singleplayer]singleplayer[/url]\n      [url=quit]quit[/url]"
	
	#margin_left = display.rect_min_size.x
	#margin_right = display.rect_size.x
	#margin_top = display.rect_min_size.y
	#margin_bottom = display.rect_size.y
	
	connect("meta_clicked", self, "handle")

func handle(argument):
	match argument:
		"singleplayer": get_tree().change_scene_to(level1)
		"quit": get_tree().quit()

func _process(delta):
	set_position(Vector2(display.rect_size.x/2-80,display.rect_size.y/2-25))
