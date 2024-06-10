extends Control

@onready var label = $HBoxContainer/Label

func _ready():
	label.text = "0"
	
func _on_coin_received(total_coins: int) -> void:
	label.text = str(total_coins)
