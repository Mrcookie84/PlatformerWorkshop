extends Node2D
class_name Level

var world_manager : WorldManager

var player : Player

var entry_points : Array[EntryPoint]

func _ready() -> void:
	entry_points = get_children() \
			.map(connect_signal_transition) \
			.filter(func(a): return a is EntryPoint)

func connect_signal_transition(n:Node) -> Node:
	if n is not SceneTransitor:
		return n
	
	var transitor : SceneTransitor = n as SceneTransitor
	transitor.connect("player_transition_request",world_manager.change_level)
	
	return n

func do_player_spawn(transition: SceneTransitionRequest) -> void:
	var entry_point : EntryPoint = entry_points.filter(func(a:EntryPoint): a.name == transition.future_spawn_point_id)[0]

	player.position = entry_point.position


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	
