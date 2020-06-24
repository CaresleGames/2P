extends Actor

var vivo := true

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

