extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Path/BirdPathFollow.offset += delta * speed
	$Path2/Bird2PathFollow.offset += delta * speed


func _on_btnPlay_pressed():
	get_tree().change_scene("res://scenes/level1.tscn")
