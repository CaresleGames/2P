extends KinematicBody2D


const SUELO := Vector2.UP

export var velocidad : int = 0
export var aceleracion : float = 0
export var gravedad := 98

var movimiento := Vector2.ZERO
var distancia : float = 0
var direccion := 0

func _ready() -> void:
	$".".modulate = Colores.COLOR_JUGADOR


func _physics_process(delta: float) -> void:
	mover(delta)


func mover(delta) -> void:
	
	direccion = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	distancia = velocidad * delta
	movimiento.x = (distancia * direccion) / delta
	movimiento.y += gravedad * delta
	
	if is_on_floor():
		movimiento.y = 0
	
	movimiento = move_and_slide(movimiento, SUELO)
