extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200
var jump = 300
var flight_height = 2
var gravity = 20
var motion = Vector3(0,0,0)
var controls_enabled = false
var gravity_enabled = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_on_floor() and gravity_enabled:
		motion.y -= gravity * delta
		
	if controls_enabled:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump * delta

		if Input.is_action_pressed("ui_left") and not (Input.is_action_pressed("ui_right")):
			motion.x = speed * delta
	
		elif Input.is_action_pressed("ui_right") and not (Input.is_action_pressed("ui_left")):
			motion.x = -(speed * delta)
		else:
			motion.x = 0
	else:
		motion.x = 0
			
	move_and_slide(motion, Vector3.UP)
	
	transform.origin.y = clamp(transform.origin.y, 0, flight_height)
	transform.origin.x = clamp(transform.origin.x, -2, 2)

	
