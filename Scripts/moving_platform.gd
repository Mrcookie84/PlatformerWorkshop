extends CharacterBody2D

@export var SPEED: float
@export var directionX: float
@export var directionY: float

var direction: Vector2

func _physics_process(delta: float) -> void:
	if velocity.x != directionX and velocity.y != directionY:
		velocity.x = move_toward(velocity.x, directionX, SPEED)
		velocity.y = move_toward(velocity.y, directionY, SPEED)
	else:
		velocity.x = move_toward(velocity.x, -directionX, SPEED)
		velocity.y = move_toward(velocity.y, -directionY, SPEED)
	
	move_and_slide()
