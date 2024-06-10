extends Node2D

@onready var character = $Player
@onready var health = $UI/Health
@onready var coin_counter = $UI/CoinCounter


func _ready():
	character.health_changed.connect(health._on_health_changed)
	character.coins_received.connect(coin_counter._on_coin_received)
