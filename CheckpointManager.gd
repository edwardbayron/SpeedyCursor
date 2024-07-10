extends Node

#@export var checkpoint_scene: PackedScene

const SCROLL_SPEED_FACTOR = 0.5
var checkpoints = []
var parallax_background_size_main = 1024

func _ready():
	pass

func spawn_checkpoint():
	var checkpoint = get_node(".")
	checkpoint.position = Vector2(250, 0)
	print("Spawning checkpoint at position:", checkpoint.position)
	add_child(checkpoint)
	checkpoints.append(checkpoint)

func _process(delta):
	var scroll_offset = GameState.get_scroll_offset_main.y * delta
	update_checkpoints(scroll_offset)

func update_checkpoints(scroll_offset):
	for checkpoint in checkpoints:
		checkpoint.position.y += scroll_offset * SCROLL_SPEED_FACTOR
		print("After update:", checkpoint.position.y)
		if checkpoint.position.y > parallax_background_size_main:
			checkpoints.erase(checkpoint)
			checkpoint.queue_free()

func _on_parallax_background_2_background_size(parallax_background_size):
	parallax_background_size_main = parallax_background_size


func _on_main_checkpoint_needed():
	spawn_checkpoint()
