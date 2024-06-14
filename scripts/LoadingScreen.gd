class_name LoadingScreen
extends Node2D

signal transition_completed

const DEFAULT_ANIMATION_NAME = "fade_to_black"

var _starting_animation_name: String

@onready var progress_bar = $Control/HBoxContainer/ProgressBar
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

func _ready():
	progress_bar.visible = false

func start_animation(animation_name: String) -> void:
	if animation_player.has_animation(animation_name):
		push_warning(animation_name + " does not exist")
		_starting_animation_name = DEFAULT_ANIMATION_NAME
	else:
		_starting_animation_name = animation_name
		
	animation_player.play(_starting_animation_name)
	timer.start()
	
func finish_animation() -> void:
	if timer:
		timer.stop()
		
	var ending_animation_name = _starting_animation_name.replace("to", "from")
	animation_player.play(ending_animation_name)
	
	await animation_player.animation_finished
	queue_free()
	
func report_mid_point() -> void:
	transition_completed.emit()
	
func _on_timer_timeout():
	progress_bar.visible = true
