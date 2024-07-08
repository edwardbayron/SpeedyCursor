extends Node

@export var meteor_scene : PackedScene
var distance_traveled_main = 0
var offset_test_main = 0
var checkpoint_spawned = false
var parallax_background_size_main = 0
var checkpoint

const CHECKPOINT_INTERVAL = 100
var next_checkpoint_distance = CHECKPOINT_INTERVAL
var checkpoints = []


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.show()
	checkpoint = get_node("CheckpointStaticBody/Sprite2D")
	checkpoint.position = Vector2(250, 0)
	next_checkpoint_distance = CHECKPOINT_INTERVAL
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("distance_traveled_main: "+str(distance_traveled_main))
	print("offset_test_main: "+str(offset_test_main))
	
	if distance_traveled_main >= next_checkpoint_distance:
		checkpoint_static_body()
		next_checkpoint_distance += CHECKPOINT_INTERVAL
	
	#if distance_traveled_main >= parallax_background_size_main:
	update_checkpoints()
	
#	if checkpoint_spawned:
#		distance_traveled_main = 0
#		distance_traveled_main += 1
	
	#print("distance_traveled_main: "+str(distance_traveled_main))
	#print("next_checkpoint_distance: "+str(next_checkpoint_distance))
	#if distance_traveled_main == 100:
		


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

func _on_parallax_background_2_distance_traveled_y(distance_traveled):
	distance_traveled_main = distance_traveled

func checkpoint_static_body():
	checkpoint.position = Vector2(0, 0)
	add_child(checkpoint)
	checkpoints.append(checkpoint)
	checkpoint_spawned = true

func update_checkpoints():
	checkpoint.position.y = distance_traveled_main - CHECKPOINT_INTERVAL

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
