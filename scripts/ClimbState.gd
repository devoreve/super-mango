class_name ClimbState
extends State

func enter() -> void:
	character.is_climbing = true
	
	if character.top_ladder:
		character.top_ladder.collision_layer = 0
	
func exit() -> void:
	character.is_climbing = false
	
	if character.top_ladder:
		character.top_ladder.collision_layer = 1
		character.top_ladder = null
	
func physics_update(delta: float) -> void:
	if character.is_knocked_back:
		state_changed.emit(StateMachine.State.KNOCKEDBACK)
		return
	
	if character.can_climb_ladder:
		animated_sprite.play("climb_rope")
	elif character.can_climb_mountain:
		animated_sprite.play("climb_mountain")
	
	if not character.can_climb_ladder and not character.can_climb_mountain:
		state_changed.emit(StateMachine.State.IDLE)
	
	if get_jump():
		state_changed.emit(StateMachine.State.JUMP)
		return
		
	if get_interaction():
		state_changed.emit(StateMachine.State.IDLE)
		return
	
	var direction: float = get_movement_input()
	
	if direction == 0:
		character.velocity.y = move_toward(character.velocity.y, 0, character.speed)
	else:
		character.velocity.y = direction * character.speed
