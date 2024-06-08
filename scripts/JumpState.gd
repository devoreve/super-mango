class_name JumpState
extends State

func enter() -> void:
	if character.is_on_floor():
		character.velocity.y = character.jump_velocity
		animated_sprite.play("jump")
		character.jump_sound.play()
	
func physics_update(delta: float) -> void:
	if character.is_knocked_back:
		state_changed.emit(StateMachine.State.KNOCKEDBACK)
		return
	
	if get_jump() and state == StateMachine.State.JUMP:
		state_changed.emit(StateMachine.State.DOUBLE_JUMP)
		
	if get_interaction() and (character.can_climb_ladder or character.can_climb_mountain):
		state_changed.emit(StateMachine.State.CLIMB)
		return
		
	var direction: float = move_component.get_movement_direction()
	
	if direction != 0:
		animated_sprite.flip_h = direction < 0
		
	character.velocity.x = direction * character.speed
	
	if character.is_on_floor():
		if direction == 0:
			state_changed.emit(StateMachine.State.IDLE)
		else:
			state_changed.emit(StateMachine.State.RUN)
