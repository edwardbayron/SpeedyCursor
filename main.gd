extends Node

@export var meteor_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.show()
	new_game()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_checkpoint_passed():
	print("PASSED")


func _on_timeline_area_checkpoint_passed():
	print("PASSED")


func _on_player_hit():
	pass # Replace with function body.
	
func game_over():
	pass


func new_game():
	$MeteorTimer.start()

func meteors_start_spawning():
	pass


func _on_meteor_timer_timeout():
	var meteor = meteor_scene.instantiate()
	var meteor_start_spawn_location = get_node("MeteorPath/MeteorSpawnLocation")
	meteor_start_spawn_location.progress_ratio = randf()
	var direction = meteor_start_spawn_location.rotation + PI / 2
	meteor.position = meteor_start_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	meteor.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	meteor.linear_velocity = velocity.rotated(direction)
	add_child(meteor)
