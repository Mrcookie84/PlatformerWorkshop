extends AnimatableBody2D

@export_group("Stats")
@export var SPEED: float
@export var end: Node2D
@export var back: bool = false
var start_pos: Vector2


func _ready() -> void:
	start_pos = self.global_position

func _physics_process(delta: float) -> void:
	if !back:
		global_position = global_position.move_toward(end.global_position, SPEED * delta)
		if global_position.distance_to(end.global_position) < 1:
			back = true
	else:
		global_position = global_position.move_toward(start_pos, SPEED * delta)
		if global_position.distance_to(start_pos) < 1:
			back = false
