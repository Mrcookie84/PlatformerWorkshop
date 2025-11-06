extends Area2D

var player: Player

func _on_body_entered(body: Node2D) -> void:
	print("entered Death Zone")
	player = body
	player._take_damage(player.health)
