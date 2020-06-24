extends Actor


export var aceleracion_salto : float = 0

var distancia : float = 0
var puedo_saltar : bool = true
var vidas_maximas : int = 3
var vidas := vidas_maximas
var muerto := false


func _physics_process(_delta: float) -> void:
	
	mover()
	


func mover() -> void:
	direccion = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if not muerto:
		if direccion > 0:
			movimiento.x = min(movimiento.x + aceleracion, velocidad)
		if direccion < 0:
			movimiento.x = max(movimiento.x - aceleracion, -velocidad)
		else:
			movimiento.x = lerp(movimiento.x, 0, friccion)
	mover_y()
	$Izquierda.force_raycast_update()
	$Centro.force_raycast_update()
	$Derecha.force_raycast_update()
	movimiento = move_and_slide(movimiento, SUELO)  


func mover_y() -> void:
	if not is_on_floor():
		movimiento.y += gravedad * get_physics_process_delta_time()

	if is_on_floor():
		movimiento.y = 0
		puedo_saltar = true
	if not is_on_floor() and $Izquierda.is_colliding() and not $Centro.is_colliding() and not $Derecha.is_colliding():
		$CoyoteJump.start()
	if not is_on_floor() and not $Izquierda.is_colliding() and not $Centro.is_colliding() and $Derecha.is_colliding():
		$CoyoteJump.start()
	if not $CoyoteJump.is_stopped():
		if Input.is_action_just_pressed("ui_salto"):
			movimiento.y = -salto
			$CoyoteJump.stop()
	if $Izquierda.is_colliding() and $Centro.is_colliding() and $Derecha.is_colliding():
		if Input.is_action_just_pressed("ui_salto"):
			movimiento.y = -salto
			$SonidoSalto.play()
			$Anim.play("Salto")
	if Input.is_action_just_pressed("ui_salto"):
		if puedo_saltar and is_on_floor():
			movimiento.y = -salto
			$TiempoSalto.start()
			$SonidoSalto.play()
			$Anim.play("Salto")
	if Input.is_action_pressed("ui_salto"):
		
		if not $TiempoSalto.is_stopped():
			movimiento.y = -aceleracion_salto
			


func _reacomodar() -> void:
	if muerto:
		$SprPlayer.hide()
		$ParticulasMuerte.emitting = true
		yield(get_tree().create_timer(1), "timeout")
		$SprPlayer.show()
		muerto = false
	position = coordenas_inicio
	vidas -= 1
	if vidas >= 1:
		show()

