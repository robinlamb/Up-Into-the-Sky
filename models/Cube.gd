extends Spatial
var picked_up = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_Area_body_entered(body):
	if not picked_up and body.is_in_group("babybird"):
		picked_up = true
		$AudioStreamPlayer3D.playing = true
		get_tree().call_group("game", "add_cube")
		$MeshInstance.visible = false
		$CPUParticles.set_emitting(true)
		$Timer.set_wait_time(1.0)
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
