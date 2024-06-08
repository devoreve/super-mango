class_name RunState
extends State
	
func physics_update(delta: float) -> void:
	if character.is_knocked_back:
		state_changed.emit(StateMachine.State.KNOCKEDBACK)
		return
	
	if get_jump():
		state_changed.emit(StateMachine.State.JUMP)
		return
	
	var direction: float = move_component.get_movement_direction()
	
	if direction == 0:
		state_changed.emit(StateMachine.State.IDLE)
		return
		
	animated_sprite.flip_h = direction < 0
	animated_sprite.play("run")
		
	character.velocity.x = direction * character.speed
