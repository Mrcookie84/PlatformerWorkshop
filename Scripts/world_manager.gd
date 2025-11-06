extends Node2D
class_name WorldManager

@export
var current_level : Level


func change_level(transition_request : SceneTransitionRequest) -> void :
	var level : Level = (ResourceLoader.load_threaded_get(transition_request.scene_to_transition) as PackedScene).instantiate()

	level.world_manager = self
	
	remove_child(current_level)
	add_child(level)
	# make shit happens like player reposition and all
