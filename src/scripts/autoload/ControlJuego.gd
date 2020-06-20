extends Node

signal reaparecer_inicio
signal reinicio
signal cambio_nivel
signal cambio_nivel_siguiente

var jugador
var enemigo 
var gui_gameover 
var inicio_juego := false
var vidas_jugador : int
var niveles : int = 0

func _ready() -> void:
	connect("reaparecer_inicio", self, "_reaparecer_inicio")
	connect("reinicio", self, "_reinicio")
	connect("cambio_nivel", self, "_cambio_nivel")
	connect("cambio_nivel_siguiente", self, "_cambio_nivel_siguiente")


func _process(_delta: float) -> void:
	if inicio_juego:
		if get_tree().get_nodes_in_group("player").size() > 0:
			jugador = get_tree().get_nodes_in_group("player")[0]
		if get_tree().get_nodes_in_group("enemigo").size() > 0:
			enemigo = get_tree().get_nodes_in_group("enemigo")[0]
		if get_tree().get_nodes_in_group("game_over").size() > 0:
			gui_gameover = get_tree().get_nodes_in_group("game_over")[0]
		if jugador.vidas <= 0 and get_tree().get_nodes_in_group("player").size() > 0:
			gui_gameover.show()
			gui_gameover.pantalla_gameover = true
			jugador.hide()
			if get_tree().get_nodes_in_group("enemigo").size() > 0:
				enemigo.hide()
		
	if Input.is_action_just_pressed("ui_accept"):
		var value = get_tree().reload_current_scene()
		print(value)
	


func _reaparecer_inicio() -> void:
	jugador._reacomodar()
	enemigo._reacomodar()


func _reinicio() -> void:
	gui_gameover.hide()
	jugador.vidas = jugador.vidas_maximas
	jugador._reacomodar()
	jugador.vidas = jugador.vidas_maximas
	if get_tree().get_nodes_in_group("enemigo").size() > 0:
		enemigo._reacomodar()


func _cambio_nivel() -> void:
	niveles = 1
	vidas_jugador = jugador.vidas


func _cambio_nivel_siguiente() -> void:
	jugador.vidas = vidas_jugador
	niveles = 0
