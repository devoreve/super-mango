class_name DoubleJumpState
extends JumpState

func enter() -> void:
	if not character.is_on_floor():
		character.velocity.y = character.jump_velocity
		animated_sprite.play("double_jump")
		character.jump_sound.play()
