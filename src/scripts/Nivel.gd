extends Node2D

signal ocultar


func _ready() -> void:
	connect("ocultar", self, "ocultar_elementos")
	
	
func ocultar_elementos() -> void:
	var hijos : Array = get_children()
	
	for hijo in hijos:
		if not hijo.is_in_group("trans"):
			if not hijo.is_in_group("canvas_padre"):
				hijo.hide()
