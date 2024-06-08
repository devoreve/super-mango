class_name GameManager
extends Node

enum State {
	STARTED,
	GAME_OVER
}

@export var default_state: GameManager.State = 0
var current_state: int
@onready var game_over_sound = $GameOverSound

signal game_state_changed(game_state)

func _init():
	current_state = default_state
	update_state(default_state)

func update_state(game_state: int):
	current_state = game_state
	
	match current_state:
		State.STARTED:
			handle_started()
		State.GAME_OVER:
			handle_game_over()
		_:
			print("State not found")
	
	game_state_changed.emit(current_state)

func handle_started() -> void:
	pass

func handle_game_over() -> void:
	Engine.time_scale = 0.5
	game_over_sound.play()
	await get_tree().create_timer(1).timeout
	Engine.time_scale = 1
	get_tree().reload_current_scene()