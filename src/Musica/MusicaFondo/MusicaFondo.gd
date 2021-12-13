extends AudioStreamPlayer

var musica_muteado := false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enabled_sound"):
		musica_muteado = not musica_muteado
		AudioServer.set_bus_mute(1, musica_muteado)
