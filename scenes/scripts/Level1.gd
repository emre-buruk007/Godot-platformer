extends Node
@onready var bgm_level_1 = $BGMLevel1


func _ready():
	bgm_level_1.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
