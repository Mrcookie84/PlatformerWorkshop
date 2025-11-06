extends Node2D

signal on_pogo

@export var animator:AnimationPlayer
@export var damage:int = 1
# Called when the node enters the scene tree for the first time.
func attack() -> void:
	animator.play("attack")
	await animator.animation_finished
	animator.play("RESET")

	
func _on_area_2d_body_entered(body) -> void:
	

	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
			print(damage)

	else:
	# Aucun méthode trouvée → log pour debug
		push_warning("L'ennemi n'a pas de méthode 'take_damage' : %s" % [body])
	
	#on_pogo.emit()
