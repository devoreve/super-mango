extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _on_body_entered(body):
	if body is Character:
		body.can_open_door = true
		body.level_completed.connect(_on_level_completed)

func _on_body_exited(body):
	if body is Character:
		body.can_open_door = false

func _on_level_completed() -> void:
	animated_sprite.play("open")
