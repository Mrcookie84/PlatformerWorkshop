class_name Player
extends CharacterBody2D

@export_group("Base_stats")
var health:int = 3
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

@export_group("Attack_param")
@export var anchor: Node2D
@export var marker: Marker2D
@export var attack_timer: Timer
@export var cooldown:float = 1
var can_attack:bool = true

@export_group("player art")
@export var player_sprite:Sprite2D
@export var animator:AnimationPlayer
var respawn:Respawn_Point

func _ready() -> void:
	health_bar.max_value = max_health
	health = max_health
	_update_health_bar()
	
func _process(delta: float) -> void:
	anchor.look_at(get_global_mouse_position())
	#Attack
	if Input.is_action_pressed("Attack"):
		animator.play("attack")
		_Attack()


func _update_health_bar():
	health_bar.value = health
	
	

func _physics_process(delta: float) -> void:
	
	var input_dir := Vector2(Input.get_axis("Backward", "Forward"), 0)
	
	if input_dir == Vector2.ZERO and !Input.is_anything_pressed():
		if animator.current_animation == "attack":
			animator.queue("RESET")
		else:
			animator.play("RESET")
	else:
		if animator.current_animation == "dash" or animator.current_animation == "attack":
			animator.queue("walking")
		else:
			animator.play("walking")
	
	
	
	# Mouvement horizontal
	velocity.x = lerp(velocity.x, input_dir.x * speed, delta * 10.0)
	
	# Sprint
	if Input.is_action_pressed("Sprint") and can_sprint:
		if velocity.x < 0:
			animator.play("dash")
			velocity.x -= sprintSpeed
		else:
			animator.play("dash")
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

func _Attack() -> void:
	
	if not can_attack:
		return
	
	%Attack.attack()
	can_attack = false
	attack_timer.start(cooldown)

func _on_attack_timer_timeout() -> void:
	can_attack = true

func take_damage(damage: int):
	health = max(0, health - damage)
	_update_health_bar()
	if health == 0:
		_die()

func _die():
	print("dead")
	if respawn:
		respawn._respawn()
	else:
		print("pas de respawn")
	#queue_free()

func _on_dash_timer_timeout() -> void:
	sprint_can_be_true = true


func _on_attack_pogo() -> void:

	velocity += Vector2.DOWN * jump_velocity
	if !sprint_can_be_true :
		can_sprint = true
	if !can_double_jump:
		can_double_jump = true
