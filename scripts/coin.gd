extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body):
	if body is Character:
		body.add_coin(1)
		animation_player.play("pickup")
