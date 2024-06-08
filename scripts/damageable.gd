extends Node2D

@export var damages: int = 1
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
	
func _on_area_2d_body_entered(body):
	if body is Character and not body.is_invincible:
		body.take_damages(damages)
		body.knocked_back(animated_sprite.global_position)
