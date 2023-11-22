extends Control



func _ready():
	$TimeLineSprite.hide()
	pass

func _process(delta):
	pass

func _on_player_timeout_counter(position):
	pass

func _on_player_spawn_line():
	print("SPAWN LINE SPAWN LINE SPAWN LINE SPAWN LINE SPAWN LINE SPAWN LINE SPAWN LINE")
	$TimeLineSprite.show()
