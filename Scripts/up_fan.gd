extends Area2D

@export var SPEED: float
@export var target_direction: Vector2

var target: Player #CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	target = body
	target.is_on_floor() == false
	print(target.is_on_floor())
	
func _on_body_exited(body: Node2D) -> void:
	print(target.is_on_floor())
	target = null

	
func _physics_process(delta: float) -> void:
	if target:
		target.velocity += target_direction * SPEED * delta
