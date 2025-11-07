extends Level

func _ready() -> void:
	player.queue_free()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")

func do_player_spawn(transition: SceneTransitionRequest) -> void:
	pass
