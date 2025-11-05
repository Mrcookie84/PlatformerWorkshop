extends Sprite2D

@export var player:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.velocity.x < 0:
		flip_h = true
	else:
		flip_h = false
