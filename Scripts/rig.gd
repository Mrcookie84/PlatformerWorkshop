extends Node2D

@export var player:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if player.velocity.x < 0:
		scale.x = -1
	else:
		scale.x = 1
