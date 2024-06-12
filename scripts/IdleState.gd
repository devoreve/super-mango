class_name IdleState
extends State

func enter() -> void:
	animated_sprite.play("idle")
	
func physics_update(delta: float) -> void:
	if move_component.interact() and character.can_open_door:
		state_changed.emit(StateMachine.State.COMPLETE_LEVEL)
		return
		
	if character.is_knocked_back:
		state_changed.emit(StateMachine.State.KNOCKEDBACK)
		return
	
	if get_jump():
		state_changed.emit(StateMachine.State.JUMP)
		return
		
	if get_interaction() and (character.can_climb_ladder or character.can_climb_mountain):
		state_changed.emit(StateMachine.State.CLIMB)
		return
	
	var direction: float = get_movement_input()
	
	if direction == 0:
		character.velocity.x = move_toward(character.velocity.x, 0, character.speed)
	else:
		state_changed.emit(StateMachine.State.RUN)
