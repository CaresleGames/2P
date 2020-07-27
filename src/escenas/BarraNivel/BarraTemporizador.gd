extends Node2D

var tiempo : float = 0

func _process(delta: float) -> void:
	tiempo += delta
	$TextureRect/Tiempo.text = str(int(tiempo))
