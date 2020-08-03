extends Node2D

func _ready() -> void:
	$TextureRect/Label.text = str(get_parent().name)
	yield(get_tree().create_timer(.2), "timeout")
	$Anim.play("Entrada")
