extends Control

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("RESET")

func _process(delta):
	if Input.is_action_just_pressed("pause") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()

func resume() -> void:
	get_tree().paused = false
	animation_player.play_backwards("blur")
	
func pause() -> void:
	get_tree().paused = true
	animation_player.play("blur")

func _on_resume_button_pressed():
	resume()

func _on_restart_button_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_exit_button_pressed():
	get_tree().quit()
