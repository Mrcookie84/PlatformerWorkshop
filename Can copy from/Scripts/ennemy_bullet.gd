extends CharacterBody2D

@export var speed: float = 100
@export var damage:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction:Vector2 = Vector2.RIGHT.rotated(global_rotation)
	var velocity:Vector2 = direction * speed
	
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)


	if collision:
		var collider: CollisionObject2D = collision.get_collider() 
		if collider.is_in_group("obstacles"):
			var new_direction = direction.bounce(collision.get_normal())
			global_rotation = new_direction.angle()
		elif collider.is_in_group("player"):
			collider._take_damage(damage)
			queue_free()
