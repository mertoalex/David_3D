extends RichTextLabel
var level1 = load("res://scenes/level1.tscn")
var main_menu = load("res://scenes/main_menu_animation.tscn")

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
		"restart": get_tree().change_scene_to(level1)
		"main_menu": get_tree().change_scene_to(main_menu)

func _process(delta):
	set_position(Vector2(display.rect_size.x/2-80,display.rect_size.y/2-25))
