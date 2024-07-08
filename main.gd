extends Node

@export var meteor_scene : PackedScene
var distance_traveled_main = 0
var offset_test_main = 0
var checkpoint_spawned = false
var parallax_background_size_main = 0


const CHECKPOINT_INTERVAL = 100
var next_checkpoint_distance = CHECKPOINT_INTERVAL
var checkpoints = []

func _ready():
	#$Player.show()
	next_checkpoint_distance = CHECKPOINT_INTERVAL
	new_game()

func _process(delta):

	print("next_checkpoint_distance: "+str(next_checkpoint_distance))
	if distance_traveled_main >= next_checkpoint_distance:
		spawn_checkpoint()
		next_checkpoint_distance += CHECKPOINT_INTERVAL
	
	update_checkpoints()
	
	print("distance_traveled_main: "+str(distance_traveled_main))

func _on_parallax_background_2_distance_traveled_y(distance_traveled):
	distance_traveled_main = distance_traveled

func spawn_checkpoint():
	var checkpoint = get_node("CheckpointStaticBody")
	checkpoint.position = Vector2(0, 0)
	add_child(checkpoint)
	checkpoints.append(checkpoint)

func update_checkpoints():
	#checkpoint.position.y = distance_traveled_main - CHECKPOINT_INTERVAL
	for checkpoint in checkpoints:
		checkpoint.position.y = distance_traveled_main - CHECKPOINT_INTERVAL
		if checkpoint.position.y > get_viewport().size.y:
			checkpoints.erase(checkpoint)
			checkpoint.queue_free()

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


func _on_parallax_background_2_background_size(parallax_background_size):
	parallax_background_size_main = parallax_background_size
	
func _on_player_checkpoint_passed():
	print("PASSED")

func _on_timeline_area_checkpoint_passed():
	print("PASSED")
	
func new_game():
	$MeteorTimer.start()
