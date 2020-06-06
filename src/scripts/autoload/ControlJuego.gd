extends Node

signal reaparecer_inicio


func _ready() -> void:
	connect("reaparecer_inicio", self, "_reaparecer_inicio")


func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept"):
		var value = get_tree().reload_current_scene()
		print(value)


func _reaparecer_inicio() -> void:
	var jugador = get_tree().get_nodes_in_group("player")[0]
	var enemigo = get_tree().get_nodes_in_group("enemigo")[0]
	jugador._reacomodar()
	enemigo._reacomodar()
