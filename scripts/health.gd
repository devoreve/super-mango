extends Node2D

var frame_index: int = 0
var total_frames: int

@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	total_frames = animated_sprite.sprite_frames.get_frame_count(animated_sprite.animation)

func _on_health_changed(current_health) -> void:
	# Update frame depending on the character current_health
	animated_sprite.frame = total_frames - current_health - 1
