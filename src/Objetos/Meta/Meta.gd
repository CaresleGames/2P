extends Area2D

export var siguiente_nivel : PackedScene

func _on_Meta_body_entered(_body: KinematicBody2D) -> void:
	ControlJuego.jugador.en_meta = true
	yield(ControlJuego.jugador.get_node("Camera2D/Tween"), "tween_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	var anim : AnimationPlayer
	var barra_vidas : Node2D
	var barra_vidas_anim : AnimationPlayer
	var barra_tiempo : Node2D
	var barra_tiempo_anim : AnimationPlayer
	if get_tree().get_nodes_in_group("BarraVidas").size() > 0:
		barra_vidas = get_tree().get_nodes_in_group("BarraVidas")[0]
		barra_vidas_anim = barra_vidas.get_node("Anim")
	if get_tree().get_nodes_in_group("BarraTiempo").size() > 0:
		barra_tiempo = get_tree().get_nodes_in_group("BarraTiempo")[0]
		barra_tiempo_anim = barra_tiempo.get_node("Anim")
	if get_tree().get_nodes_in_group("trans").size() > 0:
		var trans = get_tree().get_nodes_in_group("trans")[0]
		anim = trans.get_child(1)
	if not barra_vidas_anim == null:
		barra_vidas_anim.play("Salida")
		yield(barra_vidas_anim, "animation_finished")
	if not barra_tiempo_anim == null:
		barra_tiempo_anim.play("Salida")
	if not anim == null:
		anim.play("Entrada")
		yield(anim, "animation_finished")
		get_parent().emit_signal("ocultar")
		anim.play("Salida")
		yield(anim, "animation_finished")
		yield(get_tree().create_timer(.001), "timeout")
	ControlJuego.emit_signal("cambio_nivel")
	
	var cambio := get_tree().change_scene_to(siguiente_nivel)
	print(cambio)
