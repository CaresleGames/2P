extends Node

signal reaparecer_inicio
signal reinicio

onready var jugador = get_tree().get_nodes_in_group("player")[0]
onready var enemigo = get_tree().get_nodes_in_group("enemigo")[0]
onready var gui_gameover = get_tree().get_nodes_in_group("game_over")[0]

func _ready() -> void:
	connect("reaparecer_inicio", self, "_reaparecer_inicio")
	connect("reinicio", self, "_reinicio")

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept"):
		var value = get_tree().reload_current_scene()
		print(value)
	if jugador.vidas <= 0:
		gui_gameover.show()
		jugador.hide()
		enemigo.hide()


func _reaparecer_inicio() -> void:
	jugador._reacomodar()
	enemigo._reacomodar()


func _reinicio() -> void:
	print('reinicio')
	gui_gameover.hide()
	jugador.vidas = jugador.vidas_maximas + 1
	jugador._reacomodar()
	enemigo._reacomodar()
