extends Node2D

@onready var character = $Player
@onready var health = $UI/Health

func _ready():
	character.health_changed.connect(health._on_health_changed)
