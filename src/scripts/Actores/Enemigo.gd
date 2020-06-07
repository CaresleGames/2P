extends Actor

var vivo := true


func _physics_process(delta: float) -> void:
	if vivo:
		movimiento.y += gravedad * delta
		
		if is_on_floor():
			movimiento.y = 0
		
		movimiento.x = max(movimiento.x - aceleracion, -velocidad)
		movimiento = move_and_slide(movimiento, SUELO)


func _on_JugadorMuerte_body_entered(body: Node) -> void:
	body.hide()
	print(body.vidas)
	ControlJuego.emit_signal("reaparecer_inicio")


func _reacomodar() -> void:
	position = coordenas_inicio
	$".".show()
	vivo = true


func muerte_pinchos() -> void:
	vivo = false
