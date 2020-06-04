extends KinematicBody2D


const SUELO := Vector2.UP

export var velocidad : int = 0
export var aceleracion : float = 0
export var friccion : float = 0
export var gravedad := 98
export var salto := 100

var movimiento := Vector2.ZERO
var distancia : float = 0
var direccion := 0
var puedo_saltar : bool = false

func _ready() -> void:
	$".".modulate = Colores.COLOR_JUGADOR


func _physics_process(_delta: float) -> void:
	mover()


func mover() -> void:
	direccion = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if direccion > 0:
		movimiento.x = min(movimiento.x + aceleracion, velocidad)
	if direccion < 0:
		movimiento.x = max(movimiento.x - aceleracion, -velocidad)
	else:
		movimiento.x = lerp(movimiento.x, 0, friccion)
	mover_y()
	
	movimiento = move_and_slide(movimiento, SUELO)  


func mover_y() -> void:
	movimiento.y += gravedad * get_physics_process_delta_time()
	
	if is_on_floor():
		movimiento.y = 0
		puedo_saltar = true
	if Input.is_action_just_pressed("ui_salto"):
		movimiento.y = -salto
