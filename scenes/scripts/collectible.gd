extends Node2D
class_name Collectible
@onready var collected_sfx = $collected_sfx
#@onready var collected : AudioStreamPlayer = $"res://assets/music/SFX/coin_collect.wav"
@onready var animated_sprite_2d = $AnimatedSprite2D

func _on_body_entered(_body):
	animated_sprite_2d.visible = false
	Global.score += 10
	collected_sfx.play()
	await(collected_sfx.finished)
	queue_free()
