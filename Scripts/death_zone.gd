extends Area2D

var player: Player

func _on_body_entered(body) -> void:
	player = body
	player.take_damage(player.health)
