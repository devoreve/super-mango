extends PathFollow2D

var previous_position: Vector2

@export var speed: float = 0.1
@export var animated_sprite: AnimatedSprite2D
@export var inversed: bool = false

func _ready():
	previous_position = global_position

func _process(delta):
	progress_ratio += delta * speed
	
	var direction = global_position - previous_position
	
	if inversed:
		animated_sprite.flip_h = direction.x > 0 or direction.y < 0
	else:
		animated_sprite.flip_h = direction.x > 0
		
	previous_position = global_position
