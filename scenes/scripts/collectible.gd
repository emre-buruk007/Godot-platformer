extends Node2D
class_name Collectible
@onready var collected_sfx = $collected_sfx
@onready var collected : AudioStreamPlayer = $"res://assets/music/SFX/coin_collect.wav"

func _on_body_entered(body):
	if body.class_name == MainCharacter:
		collected.play()
		Global.score += 10
		queue_free()
	pass # Replace with function body.
