class_name Fish
extends Node2D

@export var jump_velocity: Vector2 = Vector2(0, -500)
@export var jump_waiting_time: float = 2.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity: Vector2
var jump_is_triggered: bool = false

@onready var ray_cast = $RayCast2D
@onready var timer = $Timer
@onready var animated_sprite = $Damageable/AnimatedSprite2D

func _ready():
	timer.wait_time = jump_waiting_time

func _physics_process(delta):
	if jump_is_triggered:
		return
		
	animated_sprite.flip_h = velocity.y > 0
	
	if velocity.y > 0 and ray_cast.is_colliding() and ray_cast.get_collider().is_in_group("killzone"):
		jump_is_triggered = true
		timer.start()
		
	velocity.y += gravity * delta
	position += velocity * delta

func jump() -> void:
	velocity = jump_velocity

func _on_timer_timeout():
	jump_is_triggered = false
	jump()
