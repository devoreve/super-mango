class_name KnockedBackState
extends State

func enter() -> void:
	animated_sprite.play("knocked_back")
	character.hit_sound.play()
	character.velocity = character.knocked_back_velocity
	
func exit() -> void:
	character.is_knocked_back = false
	
func physics_update(delta: float) -> void:
	if character.is_on_floor():
		state_changed.emit(StateMachine.State.IDLE)
