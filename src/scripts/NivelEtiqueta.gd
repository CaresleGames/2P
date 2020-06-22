extends Label

var vidas : int 

func _ready() -> void:
	var texto := get_parent().name
	$".".text = texto


func _process(_delta: float) -> void:
	vidas = ControlJuego.jugador.vidas
	$Vidas.text = str(vidas)
	print("vidas: " + str(vidas))
