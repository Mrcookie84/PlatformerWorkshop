extends Area2D

@export var SPEED: float
@export var distance: Vector2

var player: Player

func _on_body_entered(body: Node2D) -> void:
	player = body
func _physics_process(delta: float) -> void:
	player.velocity = player.global_position.move_toward(distance, SPEED * delta)
