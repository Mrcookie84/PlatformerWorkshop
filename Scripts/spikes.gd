extends Area2D

@export var damage: int
var _curent_target: Player

func _on_body_entered(body: CharacterBody2D) -> void:
	_curent_target = body
	_curent_target.take_damage(damage)
