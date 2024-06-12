class_name CompleteLevelState
extends State

func enter() -> void:
	animated_sprite.play("open_door")
	character.level_completed.emit()
