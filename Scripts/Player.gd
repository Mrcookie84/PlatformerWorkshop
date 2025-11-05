extends CharacterBody2D

@export_group("Base_stats")
@export var health:int = 3
@export var max_health:int = 3
@export var health_bar:ProgressBar

@export var speed:float = 750.0
@export var sprintSpeed:float = 1500.0

@export_group("Mouvement")
@export var direction : Vector2 = Vector2.ZERO
@export var stiffness: float = 10
@export var jump_velocity = -400.0
var can_double_jump:bool = false
var can_sprint:bool = true
var sprint_can_be_true:bool = true
@export var DashTimer: Timer

#@export_group("Shoot_param")
#@export var anchor: Node2D
#@export var marker: Marker2D
#@export var timer: Timer
#@export var cooldown:float = 1
#var canShoot:bool = true

@export_group("player art")
@export var player_sprite:Sprite2D

func _ready() -> void:
	health_bar.max_value = max_health
	health = max_health
	_update_health_bar()
	
func _process(delta: float) -> void:
	pass


func _update_health_bar():
	health_bar.value = health
	

func _physics_process(delta: float) -> void:
	var input_dir := Vector2(Input.get_axis("Backward", "Forward"), 0)
	
	# Mouvement horizontal
	velocity.x = lerp(velocity.x, input_dir.x * speed, delta * 10.0)
	
	# Sprint
	if Input.is_action_pressed("Sprint") and can_sprint:
		if velocity.x < 0:
			velocity.x -= sprintSpeed
		else:
			velocity.x += sprintSpeed
		can_sprint = false
		sprint_can_be_true = false
		DashTimer.start()
	
	# Gravité
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	if is_on_floor():
		can_double_jump = true
		if sprint_can_be_true:
			can_sprint = true
	
	# Saut
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
	elif Input.is_action_just_pressed("Jump") and can_double_jump:
		velocity.y = 0
		velocity.y = jump_velocity
		can_double_jump = false
	
	# Ralentissement si on touche un mur
	if is_on_wall():
		velocity.x /= 1.25
		
	
	# Applique le mouvement
	move_and_slide()


#
# a changer par autre chose 
#
#func _Shoot() -> void:
	#
	#if not canShoot:
		#return
	#
	#var projectile_scene: PackedScene = preload("res://Scenes/Bullet.tscn")
	#var projectile: CharacterBody2D = projectile_scene.instantiate()
	#
	#projectile.global_position = marker.global_position
	#projectile.global_rotation = marker.global_rotation
	#
	#get_parent().add_child(projectile)
	#
	#canShoot = false
	#timer.start(cooldown)

#func _on_shoot_timer_timeout() -> void:
	#canShoot = true

func _take_damage(damage: int):
	health = max(0, health - damage)
	_update_health_bar()
	if health == 0:
		_die()

func _die():
	queue_free()

func _on_dash_timer_timeout() -> void:
	sprint_can_be_true = true
