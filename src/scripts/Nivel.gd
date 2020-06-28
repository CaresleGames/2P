extends Node2D

signal ocultar


func _ready() -> void:
	connect("ocultar", self, "ocultar_elementos")
	ControlJuego.connect("cambio_nivel_siguiente", self, "cambio")


func _process(_delta: float) -> void:
	if ControlJuego.niveles > 0:
		ControlJuego.emit_signal("cambio_nivel_siguiente")


func ocultar_elementos() -> void:
	var hijos : Array = get_children()
	
	for hijo in hijos:
		if not hijo.is_in_group("trans"):
			if not hijo.is_in_group("canvas_padre"):
				if hijo is WorldEnvironment:
					return
				hijo.hide()


func cambio() -> void:
	print("cambio_nivel_siguiente")
