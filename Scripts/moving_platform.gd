extends AnimatableBody2D

@export var SPEED: float
@export var end: Vector2
var start_pos: Vector2
var back: bool = false

func _ready() -> void:
	start_pos = global_position
	print(start_pos)

func _physics_process(delta: float) -> void:
	if !back:
		global_position = global_position.move_toward(end, SPEED * delta)
		if global_position == end:
			back = !back
	else:
		global_position = global_position.move_toward(start_pos, SPEED * delta)
		if global_position == start_pos:
			back = !back
