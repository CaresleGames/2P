extends Control

export var siguiente_escena : PackedScene


func _on_Iniciar_pressed() -> void:
	get_tree().change_scene_to(siguiente_escena)
	ControlJuego.inicio_juego = true


func _on_Salir_pressed() -> void:
	get_tree().quit()
