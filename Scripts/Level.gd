extends Node2D
class_name Level

var world_manager : WorldManager

func _ready() -> void:
	get_children().map(connect_signal_transition)

func connect_signal_transition(n:Node) -> Node:
	if n is not SceneTransitor:
		return n
	
	var transitor : SceneTransitor = n as SceneTransitor
	transitor.connect("player_transition_request",world_manager.change_level)
	
	return n
