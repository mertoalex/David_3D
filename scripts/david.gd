extends KinematicBody
export var sensitivity	= 0.10
export var speed		= 10
export var smoothness	= 6
export var gravity		= 9
export var jump			= 10
export var wall_jump	= .6
var direction		= Vector3()
var velocity3		= Vector3()
var movement		= Vector3()
var gravity_vec		= Vector3()
var jumpable		= true
var full_contact	= false
var jump_calc		= jump
var die				= false

onready var head = $"david-fluffy-head"
onready var floor_checker = $"david-ultra-floor-checker"
onready var arm = $"david-fluffy-head/ARM"
onready var mice = $"david-fluffy-head/david-fluffy-head-view/POV/display/Poor-mice"
onready var phone_control = $"david-fluffy-head/david-fluffy-head-view/phone_control"
onready var restart = $"david-fluffy-head/david-fluffy-head-view/restart"
onready var gun_slot = $"./gun-slot"
onready var pistol = preload("res://objenes/bullet.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	if sensitivity > 1: sensitivity = 1
	if sensitivity <= 0: sensitivity = 0.01
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if OS.get_name() in ["Android", "iOS"]: phone_control.set_visible(true);
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * sensitivity))
		gun_slot.rotate_y(deg2rad(-event.relative.x * sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	if die: restart.set_visible(true)
	
	direction = Vector3.ZERO
	jump_calc = jump
	full_contact = false
	
	if floor_checker.is_colliding(): full_contact = true
	if arm.is_colliding() and arm.get_collider().is_in_group("usable"):
		mice.set_visible(true)
		if Input.is_action_just_pressed("use"):
			arm.get_collider().set("actioning", true)
	else: mice.set_visible(false)
	
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity * delta
		if is_on_wall():
			gravity_vec	= gravity_vec #TODO: slow a little bit somehow
		for index in get_slide_count():
			if get_slide_collision(index) and get_slide_collision(index).collider and get_slide_collision(index).collider.is_in_group("walljump"):
				jumpable	= true
				jump_calc	= jump * wall_jump
	elif is_on_floor() and full_contact:
		jumpable = true
		gravity_vec = -get_floor_normal() * gravity
	else:
		jumpable = true
		gravity_vec = -get_floor_normal()
	
	if Input.is_action_just_pressed("jump") and jumpable:
		gravity_vec = Vector3.UP * jump_calc
		jumpable = false
	if not die:
		if Input.is_action_pressed("front"):direction -= transform.basis.z
		if Input.is_action_pressed("back"):	direction += transform.basis.z
		if Input.is_action_pressed("left"):	direction -= transform.basis.x
		if Input.is_action_pressed("right"):direction += transform.basis.x
	
	direction = direction.normalized()
	velocity3 = velocity3.linear_interpolate(direction * speed, smoothness * delta)
	movement.z = velocity3.z + gravity_vec.z
	movement.x = velocity3.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)
	
	
	if not die and Input.is_action_just_pressed("click"):
		var pistol_dup = pistol.duplicate()
		pistol_dup.set_script(pistol.get_script())
		add_child(pistol_dup)
		
