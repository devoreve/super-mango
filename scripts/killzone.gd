extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body):
	if body is Character:
		game_manager.update_state(GameManager.State.GAME_OVER)
