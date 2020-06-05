extends Area2D

export var siguiente_nivel : PackedScene

func _on_Meta_body_entered(_body: KinematicBody2D) -> void:
	var cambio := get_tree().change_scene_to(siguiente_nivel)
	print(cambio)
