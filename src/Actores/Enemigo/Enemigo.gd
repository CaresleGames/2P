extends Actor

var vivo := true

onready var timer_tiempo_raycast : Timer = $TimerRaycast/TiempoRaycast
onready var timer_reactivar_raycast : Timer = $TimerRaycast/ReactivarRaycast
onready var raycast_direccion : RayCast2D = $RayCastDireccion

func _ready() -> void:
	direccion = -1


func _physics_process(delta: float) -> void:
	if vivo:
		movimiento.y += gravedad * delta
		
		if is_on_floor():
			movimiento.y = 0
		
		if is_on_wall():
			direccion *= -1
		
		if direccion == 1:
			movimiento.x = min(movimiento.x + aceleracion, velocidad)
		else:
			movimiento.x = max(movimiento.x - aceleracion, -velocidad)
		movimiento = move_and_slide(movimiento, SUELO)
		if not raycast_direccion.is_colliding() and raycast_direccion.enabled:
			timer_tiempo_raycast.start()


func _on_JugadorMuerte_body_entered(body: Node) -> void:
	body.muerto = true
	ControlJuego.emit_signal("reaparecer_inicio")


func _reacomodar() -> void:
	position = coordenas_inicio
	direccion = -1
	$".".show()
	vivo = true


func muerte_pinchos() -> void:
	var padre : Node2D = get_parent()
	position = padre.global_position
	vivo = false
	direccion = -1


func _on_TiempoRaycast_timeout() -> void:
	raycast_direccion.enabled = false
	direccion *= -1
	if direccion == 1:
		raycast_direccion.position = Vector2(3, 0)
	else:
		raycast_direccion.position = Vector2(-3, 0)
	timer_reactivar_raycast.start()


func _on_ReactivarRaycast_timeout() -> void:
	raycast_direccion.enabled = true

