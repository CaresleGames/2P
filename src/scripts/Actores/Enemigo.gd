extends Actor


func _physics_process(_delta: float) -> void: 
	movimiento.x = max(movimiento.x - aceleracion, -velocidad)
	movimiento = move_and_slide(movimiento, SUELO)


func _on_JugadorMuerte_body_entered(body: Node) -> void:
	body.hide()
	body.vivo = false
	print(body.vidas)
	ControlJuego.emit_signal("reaparecer_inicio")


func _reacomodar() -> void:
	position = coordenas_inicio
