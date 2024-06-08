extends Node

func get_movement_direction() -> float:
	return Input.get_axis("move_up", "move_down")
	
func want_to_jump() -> bool:
	return Input.is_action_just_pressed("jump")

func interact() -> bool:
	return Input.is_action_just_pressed("interact")
