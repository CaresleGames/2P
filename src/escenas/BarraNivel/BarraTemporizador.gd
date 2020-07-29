extends Node2D


var tiempo_iniciado := false
var tiempo : float = 0

func _process(delta: float) -> void:
	if tiempo_iniciado == true and ControlJuego.jugador.en_meta == false:
		tiempo += delta
		$TextureRect/Tiempo.text = str(int(tiempo))
	else:
		tiempo_iniciado = false
