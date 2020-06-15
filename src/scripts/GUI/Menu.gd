extends Control

export var siguiente_escena : PackedScene

onready var anim : AnimationPlayer = $Transicion/AnimationPlayer

func _ready() -> void:
	$Transicion.hide()


func _on_Iniciar_pressed() -> void:
	$Transicion.show()
	anim.play("Entrada")
	yield(anim, "animation_finished")
	anim.play("Salida")
	yield(anim, "animation_finished")
	get_tree().change_scene_to(siguiente_escena)
	ControlJuego.inicio_juego = true


func _on_Salir_pressed() -> void:
	get_tree().quit()
