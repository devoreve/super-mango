extends Camera2D

@export_category("Player")
@export var player: Character

@export_category("Smoothing")
@export var smoothing_enabled: bool
@export_range(1, 10) var smoothing_distance : int = 8

var weight: float

func _ready():
	if smoothing_enabled:
		weight = float(11 - smoothing_distance) / 100

func _physics_process(delta):
	if player != null:
		var camera_position : Vector2
		
		if smoothing_enabled:
			camera_position = lerp(global_position, player.global_position, weight)
		else:
			camera_position = player.global_position
			
		global_position = camera_position.floor()
