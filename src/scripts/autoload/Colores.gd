extends Node

const COLOR_JUGADOR : Color = Color("#2CE8F5")
const COLOR_ENEMIGO : Color = Color("#FF0044")
const COLOR_FONDO : Color = Color("#181425")



func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept"):
		var value = get_tree().reload_current_scene()
		print(value)
