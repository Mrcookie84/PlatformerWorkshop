extends Area2D
class_name SceneTransitor

signal player_transition_request(transition_request : SceneTransitionRequest)

@export
var transition_request : SceneTransitionRequest

func _ready() -> void:
	assert(transition_request,"transition not set")

func _on_player_enter(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("player")):
		player_transition_request.emit(transition_request)

