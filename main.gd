extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.show()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_checkpoint_passed():
	print("PASSED")


func _on_timeline_area_checkpoint_passed():
	print("PASSED")
