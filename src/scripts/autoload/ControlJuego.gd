extends Node

signal reaparecer_inicio
signal reinicio

var jugador
var enemigo 
var gui_gameover 
var inicio_juego := false


func _ready() -> void:
	connect("reaparecer_inicio", self, "_reaparecer_inicio")
	connect("reinicio", self, "_reinicio")

func _process(_delta: float) -> void:
	if inicio_juego:
		jugador = get_tree().get_nodes_in_group("player")[0]
		if get_tree().get_nodes_in_group("enemigo").size() > 0:
			enemigo = get_tree().get_nodes_in_group("enemigo")[0]
		if get_tree().get_nodes_in_group("game_over").size() > 0:
			gui_gameover = get_tree().get_nodes_in_group("game_over")[0]
		if jugador.vidas <= 0:
			gui_gameover.show()
			jugador.hide()
			enemigo.hide()
	if Input.is_action_just_pressed("ui_accept"):
		var value = get_tree().reload_current_scene()
		print(value)
	


func _reaparecer_inicio() -> void:
	jugador._reacomodar()
	enemigo._reacomodar()


func _reinicio() -> void:
	print('reinicio')
	gui_gameover.hide()
	jugador.vidas = jugador.vidas_maximas + 1
	jugador._reacomodar()
	enemigo._reacomodar()
