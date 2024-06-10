extends Control

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.game_state_changed.connect(_on_game_state_change)
	
func _on_game_state_change(state: GameManager.State) -> void:
	if state == GameManager.State.GAME_OVER:
		animation_player.play("game_over")
		visible = true
	else:
		visible = false

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	
func _on_exit_button_pressed():
	get_tree().quit()
