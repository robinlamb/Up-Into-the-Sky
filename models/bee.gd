extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bee_motion = Vector3(0,0,0)
var speed = 3
var going_forward = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(2.0)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bee_motion.x = speed
	move_and_slide(bee_motion)


func _on_Timer_timeout():
	if going_forward:
		going_forward = false
		$Armature.set_rotation_degrees(Vector3(0, 180, 0))
		$Area/CollisionShape.set_rotation_degrees(Vector3(0,180,0))
	else:
		going_forward = true
		$Armature.set_rotation_degrees(Vector3(0, 0, 0))
		$Area/CollisionShape.set_rotation_degrees(Vector3(0,0,0))
	speed = -speed
