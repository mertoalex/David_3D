extends KinematicBody
export var speed		= 45
export var smoothness	= 6
var direction		= Vector3()
var velocity3		= Vector3()
var first			= true

onready var posx_parent = $"../david-fluffy-head"
onready var posy_parent = $".."
onready var gun = $"../gun-slot"
onready var parent = get_parent()

func _ready():
	if not posx_parent: posx_parent = $"."
	if not posy_parent: posy_parent = $"."
	#print(transform.origin)
	if parent.is_in_group("player"):
		rotation.x = posx_parent.rotation.x * -1
		rotation.y = rotation.y + posy_parent.rotation.y
		transform.origin = gun.global_transform.origin #+ parent.transform.origin
		#print(transform.origin)
		
		var now_parent = parent.get_parent()
		var bullet_dup = duplicate()
		bullet_dup.set_script(get_script())
		get_parent().remove_child(self)
		now_parent.add_child(bullet_dup)
		return queue_free()
#	print("start")

func _process(delta):
	if visible:
		var kcollider = get_last_slide_collision()
		if kcollider and kcollider.collider:
			#print("end")
			if kcollider.collider.is_in_group("player"):
				kcollider.collider.set("die", true)
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			elif kcollider.collider.is_in_group("alive"): kcollider.collider.queue_free()
			return queue_free()
		
		direction = Vector3.ZERO
		direction += transform.basis.z
		
		#print(direction)
		
		direction = direction.normalized() 
		velocity3 = velocity3.linear_interpolate(direction * speed, smoothness * delta)
		
		return move_and_slide(velocity3, Vector3.UP)
		#var kcollider = move_and_collide(velocity3)
		#if kcollider and kcollider.collider.is_in_group("alive"):
		#	kcollider.collider.queue_free()
		#	return queue_free()
	else:
		#print("no process")
		set_process(false)
