class_name Respawn_Point
extends Node2D

var player:Player
var _is_checkpoint_active: bool = false

func _on_area_entered(body: CharacterBody2D) -> void:
	player = body
	player.respawn = self
	_is_checkpoint_active = true
	print(name, _is_checkpoint_active)
	
func _respawn() -> void:
	player.global_position = global_position
	player.health = player.max_health
	player._update_health_bar()
