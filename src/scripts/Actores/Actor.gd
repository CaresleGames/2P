class_name Actor
extends KinematicBody2D

enum Tipo {JUGADOR, ENEMIGO}

const SUELO := Vector2.UP

export (Tipo) var tipo := Tipo.JUGADOR 
export var velocidad : int = 0
export var aceleracion : float = 0
export var friccion : float = 0
export var gravedad := 250
export var salto := 120

var movimiento := Vector2.ZERO
var direccion := 0

func _ready() -> void:
	if tipo == Tipo.JUGADOR:
		$".".modulate = Colores.COLOR_JUGADOR
	if tipo == Tipo.ENEMIGO:
		$".".modulate = Colores.COLOR_ENEMIGO
