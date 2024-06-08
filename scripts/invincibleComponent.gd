extends Node

@export var character: Character
@onready var timer = $Timer

func start_invincible_mode() -> void:
	character.is_invincible = true
	character.animation_player.play("invincible")
	timer.start()
	

func _on_timer_timeout():
	character.is_invincible = false
	character.animation_player.stop()
