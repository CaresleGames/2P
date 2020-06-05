extends Area2D

export var siguiente_nivel : PackedScene

func _on_Meta_body_entered(body: KinematicBody2D) -> void:
#	if body.collision_layer == 1:
#		body.queue_free()
	get_tree().change_scene_to(siguiente_nivel)
	
