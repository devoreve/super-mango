extends PathFollow2D

var previous_position: Vector2

@export var speed: float = 0.1
@export var animated_sprite: AnimatedSprite2D

func _ready():
	previous_position = global_position

func _process(delta):
	progress_ratio += delta * speed
	
	var direction = global_position - previous_position
	
	animated_sprite.flip_h = direction.x > 0
	previous_position = global_position
