extends PathFollow2D

@export var speed: float = 0.1

var is_triggered: bool = false

func _ready():
	pass

func _process(delta):
	if is_triggered:
		progress_ratio += delta * speed
		global_position.x = int(global_position.x)
		global_position.y = int(global_position.y)
