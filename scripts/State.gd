class_name State
extends Node

signal state_changed

@export var state: StateMachine.State
@export var character: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
@export var move_component: Node

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
	
func get_movement_input() -> float:
	return move_component.get_movement_direction()
	
func get_jump() -> bool:
	return move_component.want_to_jump()
	
func get_interaction() -> bool:
	return move_component.interact()
