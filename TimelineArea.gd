extends Area2D

signal checkpoint_passed

# Called when the node enters the scene tree for the first time.
func _ready():
	$CheckpointSprite.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_spawn_line():
	print("SPAWN LINE")
	$CheckpointSprite.show()

