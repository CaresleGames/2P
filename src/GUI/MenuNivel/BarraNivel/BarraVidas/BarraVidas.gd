extends Node2D


func _process(_delta: float) -> void:
	if not ControlJuego.inicio_juego:
		$TextureRect/Label.text = "0"
	else:
		$TextureRect/Label.text = str(ControlJuego.jugador.vidas)
