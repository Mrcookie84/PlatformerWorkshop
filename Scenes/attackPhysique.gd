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
	var collider: CollisionObject2D = body.get_collider() 
	
	if collider.is_in_group("enemies"):
		collider._take_damage(damage)
	
	on_pogo.emit()
