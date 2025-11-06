extends Area2D

@export var SPEED: float
@export var target_direction: Vector2

var target: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	target = body
	target.global_position = target.global_position.move_toward(target_direction, SPEED)
