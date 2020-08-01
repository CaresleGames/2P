extends Control

func _ready() -> void:
	yield(get_tree().create_timer(0.05), "timeout")
	$Anim.play("Cuenta")


func _on_Anim_animation_finished(anim_name: String) -> void:
	if not anim_name == "Cuenta":
		return
	if not ControlJuego.temporizador == null:
		ControlJuego.temporizador.tiempo_iniciado = true
	
