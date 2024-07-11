extends Node

#@export var meteor_scene : PackedScene
var distance_traveled_main = 0
var checkpoint_spawned = false
var parallax_background_size_main = 1024

var offset_test_main = Vector2(0, 0)
#var get_scroll_offset_main = Vector2(0, 0)
var acceleration_main = 1
var delta_main = 1
var speed_main = 0


const CHECKPOINT_INTERVAL = 100
var next_checkpoint_distance
var checkpoints = []

const SCROLL_SPEED_FACTOR = 0.5

signal checkpoint_needed

func _ready():
	#$Player.show()
	next_checkpoint_distance = GameState.checkpoint_interval
	new_game()

func _process(delta):
	var scroll_offset = GameState.get_scroll_offset_main.y * delta
	offset_test_main = int((offset_test_main.y + scroll_offset)) % parallax_background_size_main
	
	#print("next_checkpoint_distance: "+str(next_checkpoint_distance))
	
#	if distance_traveled_main >= next_checkpoint_distance:
#		spawn_checkpoint()
#		next_checkpoint_distance += CHECKPOINT_INTERVAL
#
#	update_checkpoints(scroll_offset)

	if GameState.distance_traveled >= next_checkpoint_distance:
		emit_signal("checkpoint_needed")
		next_checkpoint_distance += GameState.checkpoint_interval
	
	update_distance_traveled(scroll_offset)
	

func _on_parallax_background_2_background_offset_changing(offset, get_scroll_offset, acceleration, delta):
	offset_test_main = offset
	GameState.get_scroll_offset_main = get_scroll_offset
	acceleration_main = acceleration
	delta_main = delta

func _on_parallax_background_2_distance_traveled_y(distance_traveled):
	GameState.distance_traveled = distance_traveled

func update_distance_traveled(scroll_offset):
	GameState.distance_traveled += scroll_offset

#func spawn_checkpoint():
#	var checkpoint = get_node("CheckpointStaticBody")
#	checkpoint.position = Vector2(250, 0)
#	print("Spawning checkpoint at position:", checkpoint.position)
#	add_child(checkpoint)
#	checkpoints.append(checkpoint)

#func update_checkpoints(scroll_offset):
#	for checkpoint in checkpoints:
#		checkpoint.position.y += scroll_offset * SCROLL_SPEED_FACTOR
#		print("After update:", checkpoint.position.y)
#		if checkpoint.position.y > parallax_background_size_main:
#			checkpoints.erase(checkpoint)
#			checkpoint.queue_free()

func meteors_start_spawning():
	pass

func _on_meteor_timer_timeout():
	var meteor_scene = load("res://meteors.tscn")
	var meteor = meteor_scene.instantiate()
	var meteor_start_spawn_location = get_node("MeteorPath/MeteorSpawnLocation")
	meteor_start_spawn_location.progress_ratio = randf()
	GameState.meteor_direction = meteor_start_spawn_location.rotation + PI / 2
	var direction = GameState.meteor_direction
	meteor.position = meteor_start_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	meteor.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	meteor.linear_velocity = velocity.rotated(direction)
	add_child(meteor)

func _on_checkpoint_static_body_area_entered(area):
	print("checkpoint entered")
#	for checkpoint in checkpoints:
#		checkpoints.erase(checkpoint)
#		checkpoint.queue_free()

func _on_parallax_background_2_background_size(parallax_background_size):
	parallax_background_size_main = parallax_background_size
	
func _on_player_checkpoint_passed():
	print("PASSED")

func _on_timeline_area_checkpoint_passed():
	print("PASSED")
	
func new_game():
	$MeteorTimer.start()

func _on_player_speed_counter(speed):
	speed_main = speed

