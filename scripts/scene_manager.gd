extends Node

var _scene_to_load: String
var _load_scene_into: Node
var _scene_to_unload: Node
var _load_progress_timer: Timer
var _loading_is_in_progress: bool = false
var _loading_screen_scene: PackedScene = preload("res://scenes/loading_screen.tscn")
var _loading_screen: LoadingScreen

signal _finished_loading_scene(loaded_scene: Node)

func _ready():
	_finished_loading_scene.connect(_on_finished_loading_scene)

func switch_scene(scene_to_load: String, scene_to_unload: Node = null, load_scene_into: Node = null) -> void:
	if _loading_is_in_progress:
		push_error("A scene is already loading")
		return
		
	_loading_is_in_progress = true
	
	if not load_scene_into:
		_load_scene_into = get_tree().root
	else:
		_load_scene_into = load_scene_into
	
	_scene_to_load = scene_to_load
	_scene_to_unload = scene_to_unload
	
	_add_loading_screen()
	_load_scene()
	
func _add_loading_screen() -> void:
	_loading_screen = _loading_screen_scene.instantiate() as LoadingScreen
	get_tree().root.add_child(_loading_screen)
	_loading_screen.start_animation("fade_to_black")
	
func _load_scene() -> void:
	await _loading_screen.transition_completed
	
	var loader = ResourceLoader.load_threaded_request(_scene_to_load)
	
	if not ResourceLoader.exists(_scene_to_load) or loader == null:
		push_error("scene does not exist")
		return
		
	print(_scene_to_load, _scene_to_unload)
		
	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(_monitor_load_status)
	
	get_tree().root.add_child(_load_progress_timer)
	_load_progress_timer.start()

func _monitor_load_status() -> void:
	var load_progress = []
	var load_status = ResourceLoader.load_threaded_get_status(_scene_to_load, load_progress)
	
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			push_error("Invalid scene")
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# Update loading screen
			print("Progress : " + load_progress[0])
		ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Loading failed")
			_load_progress_timer.stop()
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			_finished_loading_scene.emit(ResourceLoader.load_threaded_get(_scene_to_load).instantiate())

func _on_finished_loading_scene(loaded_scene: Node) -> void:
	_load_scene_into.add_child(loaded_scene)
	
	if _scene_to_unload != null and _scene_to_unload != get_tree().root:
		_scene_to_unload.queue_free()
