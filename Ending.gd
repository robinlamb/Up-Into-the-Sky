extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1
var motion_up = Vector3(0, 0, 0)
var moving_up = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$StuffToFly/babybird.gravity_enabled = false
	$Timer.set_wait_time(12.0)
	$Timer.start()
	$ScreenFade/AnimationPlayer.play("fadein")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving_up:
		motion_up.y = speed
		$StuffToFly.move_and_slide(motion_up)


func _on_Timer_timeout():
	moving_up = false
	$btnPlayAgain.visible = true


func _on_btnPlayAgain_pressed():
	get_tree().change_scene("res://scenes/level1.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	$ScreenFade.visible = false
