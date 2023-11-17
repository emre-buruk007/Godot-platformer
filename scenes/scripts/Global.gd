extends Node

var score = 0

var types_of_enemies = ["FlyingEnemy", "CrawlingEnemy", "UnkillableEnemy"]

signal set_camera_target(target: CharacterBody2D)

# This will emit the above signal
func emit_set_camera_target(target: CharacterBody2D) -> void:
	set_camera_target.emit(target)


# This will stop the engine from processing player physics
func player_freeze(player: CharacterBody2D) -> void:
	player.set_physics_process(false)
