extends Node2D
class_name WorldManager

@export
var current_level : Level

@onready
var tree: SceneTree = get_tree()

@export
var player: Player

func change_level(transition_request : SceneTransitionRequest) -> void :
	var path : String = ResourceUID.uid_to_path(transition_request.scene_to_transition)

	ResourceLoader.load_threaded_request(path)

	while ResourceLoader.load_threaded_get_status(path) == 1 :
		await tree.process_frame

	var level : Level = ResourceLoader.load_threaded_get(path).instantiate()


	level.world_manager = self
	
	current_level.queue_free()
	add_child(level)
	current_level = level

	# make shit happens like player reposition and all
	
	level.player = player
	level.do_player_spawn(transition_request)
