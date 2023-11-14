extends Node


var score = 0

# This will stop the engine from processing player physics
func player_freeze(player: CharacterBody2D) -> void:
	player.set_physics_process(false)
