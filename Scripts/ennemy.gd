extends CharacterBody2D

@export_group("Health")
@export var health:int = 3
@export var max_health:int = 3
@export var health_bar:ProgressBar
var _is_dead: bool = false

@export_group("Shoot")
@export var anchor: Node2D
@export var marker: Marker2D
@export var shoot_timer: Timer
@export var cooldown: float = 1.0

@export_group("lookAround")
@export var look_timer: Timer
@export var sprite:Sprite2D
var scale_stock:float
@export var speed: float = 500

var _current_target: PhysicsBody2D
var can_shoot: bool = true
var have_looked: bool = false
var rng := RandomNumberGenerator.new()
var player_in_range: bool = false
var look_around: Vector2 = Vector2.ZERO
var target: Node2D = null

var start_position:Node2D
var left_position:Node2D
var right_position:Node2D

func _ready() -> void:
	health_bar.max_value = max_health
	health = max_health
	_update_health_bar()
	
	scale_stock = sprite.scale.x
	
func _process(delta: float) -> void:
	if player_in_range:
		var target_pos = Vector2(target.global_position.x, target.global_position.y)
		global_position = global_position.move_toward(target_pos, speed * delta)
	
	if player_in_range and target:
		anchor.look_at(target.global_position)
	else:
		_look_around()


func _physics_process(delta: float) -> void:
	if not _current_target:
		return
	
	# --- Gravité
	velocity.y += get_gravity().y * delta

	var direction_to_player = sign(_current_target.global_position - global_position)
	velocity.x = direction_to_player * speed
	

	move_and_slide()

func _update_health_bar():
	health_bar.value = health


func _look_around() -> void:
	
		
	if _is_dead:
		return
	if have_looked:
		return
	
	if rng.randi_range(-100, 100) < 0:
		sprite.scale.x = -scale_stock
	else:
		sprite.scale.x = scale_stock
	
	look_timer.start()
	have_looked = true

func _shoot() -> void:
	if _is_dead:
		return
	if not target:
		return
	
	
	var projectile_scene: PackedScene = preload("res://Scenes/ennemy_bullet.tscn")
	var projectile: CharacterBody2D = projectile_scene.instantiate()
	
	projectile.global_position = marker.global_position
	projectile.global_rotation = marker.global_rotation
	
	get_parent().call_deferred("add_child", projectile)


func take_damage(damage: int):
	health = max(0, health - damage)
	_update_health_bar()
	if health == 0:
		_die()


func _die():
	if _is_dead:
		return

	_is_dead = true
	$AnimationPlayer.play("Death")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_range = true
	target = body
	if can_shoot:
		look_at(target.global_position)
		_fire_with_cooldown()

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
	target = null
	can_shoot = true
	shoot_timer.stop()

func _fire_with_cooldown() -> void:
	_shoot()
	can_shoot = false
	shoot_timer.wait_time = cooldown
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	if not player_in_range or not target:
		can_shoot = true
		return
	_fire_with_cooldown()

func _on_look_around_timer_timeout() -> void:
	have_looked = false
