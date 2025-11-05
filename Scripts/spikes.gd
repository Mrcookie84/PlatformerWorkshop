extends Area2D

@export var damage: int
var _curent_target: PhysicsBody2D

func _on_body_entered(body: Node2D) -> void:
	_curent_target = body
	_curent_target.takeDamage(damage)
