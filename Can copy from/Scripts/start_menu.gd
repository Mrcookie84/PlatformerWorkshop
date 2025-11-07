extends Control

@export_group("Buttons")
@export var play:Button
@export var quit:Button
@export var option_background:TextureRect

var in_option:bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_quit_pressed_QUIT() -> void:
	get_tree().quit()


func _on_option_pressed_OPTION() -> void:
	if !in_option:
		in_option = true
		option_background.visible = true
		play.disabled = true
		quit.disabled = true
	else:
		in_option = false
		option_background.visible = false
		play.disabled = false
		quit.disabled = false
