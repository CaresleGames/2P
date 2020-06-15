extends Area2D

export var siguiente_nivel : PackedScene

func _on_Meta_body_entered(_body: KinematicBody2D) -> void:
	var anim : AnimationPlayer
	if get_tree().get_nodes_in_group("trans").size() > 0:
		var trans = get_tree().get_nodes_in_group("trans")[0]
		anim = trans.get_child(1)
	if not anim == null:
		anim.play("Entrada")
		yield(anim, "animation_finished")
		anim.play("Salida")
		yield(anim, "animation_finished")
		yield(get_tree().create_timer(.001), "timeout")
	
	var cambio := get_tree().change_scene_to(siguiente_nivel)
	print(cambio)
