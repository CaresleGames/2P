extends Label

var vidas : int 

func _ready() -> void:
	var texto := get_parent().name
	$".".text = texto


func _process(_delta: float) -> void:
	if not ControlJuego.inicio_juego:
		$Vidas.text = "0"
	else:
		vidas = ControlJuego.jugador.vidas
		$Vidas.text = str(vidas)
