extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 12
var cubes_collected = 0
var current_flight_level = 1
var motion_stuff = Vector3(0, 0, 0)
var game_playing = true
var game_won = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$babybird.controls_enabled = true
	$babybird.gravity_enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if game_playing:
	#	motion_stuff.z = -speed
	#	$ConveyerBelt.move_and_slide(motion_stuff)
	$CubesLabel.text = "Cubes: " + str(cubes_collected)
	$lblFlightLevel.text = "Flight Level: " + str(current_flight_level)

func add_cube():
	cubes_collected += 1
	if cubes_collected == 5:
		$babybird.flight_height = 3
		raise_flight_level()
	if cubes_collected == 10:
		$babybird.flight_height = 4
		raise_flight_level()
	if cubes_collected == 15:
		game_won = true
		raise_flight_level()
	

func raise_flight_level():
	current_flight_level += 1
	$LevelUp.playing = true
	if game_won:
		$lblLevelUp.text = "You Win!"
		$tmrLevelUpLabel.set_wait_time(2.0)
	else:
		$tmrLevelUpLabel.set_wait_time(1.0)
	
	$lblLevelUp.visible = true
	$tmrLevelUpLabel.start()
	
func _on_ObjectDestroyer_area_entered(area):
	if area.is_in_group("cube"):
		area.get_parent().queue_free()
		game_playing = false
		$lblGameOver.visible = true
		$Button.visible = true
		$babybird.controls_enabled = false
		$DialogueBox/Label.text = "Dad:\nOh, no! You missed a cube! Better try again."
	if area.is_in_group("obstacles"):
		area.get_parent().queue_free()
		print("destroyed")

func _on_Button_pressed():
	get_tree().reload_current_scene()

func hit_obstacle():
	if not game_won:
		$HitSound.playing = true
		game_playing = false
		$lblGameOver.visible = true
		$Button.visible = true
		$babybird.controls_enabled = false
		$DialogueBox/Label.text = "Mom:\nBe careful! Don't run into anything!"
	




func _on_tmrLevelUpLabel_timeout():
	$lblLevelUp.visible = false
	if game_won:
		$tmrGameWonFade.set_wait_time(1.0)
		game_playing = false
		$ScreenFade.visible = true
		$ScreenFade/AnimationPlayer.play("screenfade")
		$tmrGameWonFade.start()


func _on_tmrGameWonFade_timeout():
	get_tree().change_scene("res://Ending.tscn")
