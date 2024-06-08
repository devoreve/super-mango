class_name Character
extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Damaging mechanic
var is_invincible: bool = false
var is_knocked_back: bool = false
var knocked_back_velocity: Vector2

# Climbing mechanic
var can_climb_ladder: bool = false
var can_climb_mountain: bool = false
var is_climbing: bool = false

# Top ladder
var top_ladder: PhysicsBody2D

@export var speed: int = 130
@export var jump_velocity: int = -300
@export var health: int:
	set(value):
		health = clamp(value, 0, 7)
@export var coins: int = 0:
	set(value):
		if value > 0:
			coins = value

signal health_changed(current_health)
signal coins_received(total_coins)

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump_sound = $Sounds/JumpSound
@onready var hit_sound = $Sounds/HitSound
@onready var invincible_component = $InvincibleComponent
@onready var game_manager = %GameManager

func _process(_delta):
	can_climb_mountain = ray_cast_right.is_colliding() or ray_cast_left.is_colliding()
	
	if ray_cast_down.is_colliding():
		var collider = ray_cast_down.get_collider()
		if collider.is_in_group("top_ladder"):
			top_ladder = collider
			return

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and not is_climbing:
		velocity.y += gravity * delta

	move_and_slide()

func take_damages(damages: int) -> void:
	if is_invincible:
		return
	
	health -= damages
	health_changed.emit(health)
	
	if is_dead():
		game_manager.update_state(GameManager.State.GAME_OVER)
		get_node("CollisionShape2D").queue_free()
		return
		
	# Invincibility mode
	invincible_component.start_invincible_mode()
	
func add_coin(total: int) -> void:
	coins += total
	coins_received.emit(coins)
	
func is_dead() -> bool:
	return health == 0
	
func knocked_back(enemy_position) -> void:
	is_knocked_back = true
	
	# Reverse velocity if player is behind the enemy
	var position_relative = animated_sprite.global_position.x - enemy_position.x
	knocked_back_velocity = Vector2(speed, float(jump_velocity) / 2)
	knocked_back_velocity.x *= 1 if position_relative > 0 else -1
