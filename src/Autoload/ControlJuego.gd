extends Node

signal reaparecer_inicio
signal jugador_acomodado
signal reinicio
signal cambio_nivel
signal cambio_nivel_siguiente

var jugador : KinematicBody2D
var enemigo : KinematicBody2D
var pinchos : Array
var temporizador : Node2D
var gui_gameover 
var inicio_juego := false
var vidas_jugador : int
var niveles : int = 0

# Variables temporales
var sonido_muteado := false


func _ready() -> void:
	connect("reaparecer_inicio", self, "_reaparecer_inicio")
	connect("reinicio", self, "_reinicio")
	connect("cambio_nivel", self, "_cambio_nivel")
	connect("cambio_nivel_siguiente", self, "_cambio_nivel_siguiente")
	connect("jugador_acomodado", self, "_jugador_acomodado")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_efectos"):
		var efecto_mundo : WorldEnvironment = get_tree().get_nodes_in_group("efectos")[0]
		efecto_mundo.environment.glow_enabled = not efecto_mundo.environment.glow_enabled
	if Input.is_action_just_pressed("enabled_sound"):
		sonido_muteado = not sonido_muteado
		AudioServer.set_bus_mute(2, sonido_muteado)
	if inicio_juego:
		if get_tree().get_nodes_in_group("BarraTiempo").size() > 0:
			temporizador = get_tree().get_nodes_in_group("BarraTiempo")[0]
		if get_tree().get_nodes_in_group("player").size() > 0:
			jugador = get_tree().get_nodes_in_group("player")[0]
			if jugador.en_meta:
				jugador.emit_signal("llegue_meta")
				jugador.en_meta = false
		if get_tree().get_nodes_in_group("enemigo").size() > 0:
			enemigo = get_tree().get_nodes_in_group("enemigo")[0]
		if get_tree().get_nodes_in_group("pinchos_caen").size() > 0:
			pinchos = get_tree().get_nodes_in_group("pinchos_caen")
		if get_tree().get_nodes_in_group("game_over").size() > 0:
			gui_gameover = get_tree().get_nodes_in_group("game_over")[0]
		if get_tree().get_nodes_in_group("player").size() > 0:
			if  jugador.vidas <= 0:
				gui_gameover.show()
				gui_gameover.pantalla_gameover = true
				jugador.hide()
				if get_tree().get_nodes_in_group("enemigo").size() > 0:
					enemigo.hide()
		if get_tree().get_nodes_in_group("BarraTiempo").size() > 0: 
			if ControlJuego.temporizador.tiempo_iniciado:
				ControlJuego.jugador.puedo_mover = true
	if Input.is_action_just_pressed("ui_accept"):
#		var value = get_tree().reload_current_scene()
#		print(value)
		jugador.en_meta = true
	


func _reaparecer_inicio() -> void:
	jugador._reacomodar()


func _jugador_acomodado() -> void:
	if get_tree().get_nodes_in_group("enemigo").size() > 0:
		enemigo._reacomodar()
	if get_tree().get_nodes_in_group("pinchos_caen").size() > 0:
		for p in pinchos:
			p._reacomodar()


func _reinicio() -> void:
	gui_gameover.hide()
	jugador.vidas = jugador.vidas_maximas
	jugador.muerto = false
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
