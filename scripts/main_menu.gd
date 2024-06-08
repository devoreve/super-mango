extends Control

@onready var main_menu_container = $MainMenuContainer
@onready var settings_container = $SettingsContainer
@onready var fullscreen_button = $SettingsContainer/HBoxContainer/InputContainer/FullscreenButton
@onready var volume_slider = $SettingsContainer/HBoxContainer/InputContainer/VolumeSlider
@onready var music_slider = $SettingsContainer/HBoxContainer/InputContainer/MusicSlider
@onready var sfx_slider = $SettingsContainer/HBoxContainer/InputContainer/SFXSlider

const CONFIG_PATH = "user://settings.cfg"
var config = ConfigFile.new()

func _ready():
	var error = config.load(CONFIG_PATH)
	
	if error != OK:
		return
	
	fullscreen_button.button_pressed = config.get_value("display", "fullscreen", false)
	volume_slider.value = config.get_value("audio", "global", 1)
	music_slider.value = config.get_value("audio", "music", 1)
	sfx_slider.value = config.get_value("audio", "sfx", 1)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_exit_button_pressed():
	get_tree().quit()

func _on_settings_button_pressed():
	main_menu_container.visible = false
	settings_container.visible = true
	
func _on_back_to_main_menu_button_pressed():
	save_settings()
	main_menu_container.visible = true
	settings_container.visible = false

func _on_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))

func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func save_settings() -> void:
	config.set_value("display", "fullscreen", fullscreen_button.button_pressed)
	config.set_value("audio", "global", volume_slider.value)
	config.set_value("audio", "music", music_slider.value)
	config.set_value("audio", "sfx", sfx_slider.value)
	
	config.save(CONFIG_PATH)
