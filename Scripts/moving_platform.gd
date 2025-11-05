extends AnimatableBody2D

@export var SPEED: float
@export var start: Vector2
@export var end: Vector2

var back: bool = false

func _physics_process(delta: float) -> void:
	if !back:
		global_position = global_position.move_toward(end, SPEED * delta)
		if global_position == end:
			back = !back
	elif back:
		global_position = global_position.move_toward(start, SPEED * delta)
		if global_position == start:
			back = !back
