extends Actor

signal llegue_meta

export var aceleracion_salto : float = 0

var distancia : float = 0
var puedo_saltar : bool = true
var vidas_maximas : int = 3
var vidas := vidas_maximas
var muerto := false
var snap := Vector2(0, 16)
var angulo := deg2rad(45)
var en_meta := false


func _ready() -> void:
	$".".connect("llegue_meta", self, "en_meta")


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
	movimiento = move_and_slide_with_snap(movimiento,
			 snap, SUELO, true, 4, angulo, false)  


func mover_y() -> void:
	if not is_on_floor():
		movimiento.y += gravedad * get_physics_process_delta_time()

	if is_on_floor():
		movimiento.y = 0
		snap = Vector2(0, 16)
		puedo_saltar = true
	
	if not is_on_floor() and $Izquierda.is_colliding() and not $Centro.is_colliding() and not $Derecha.is_colliding() and not is_on_wall():
		$CoyoteJump.start()
	if not is_on_floor() and not $Izquierda.is_colliding() and not $Centro.is_colliding() and $Derecha.is_colliding() and not is_on_wall():
		$CoyoteJump.start()
		
	if not $CoyoteJump.is_stopped():
		if Input.is_action_just_pressed("ui_salto"):
			movimiento.y = -salto
			$CoyoteJump.stop()
	if $Izquierda.is_colliding() and $Centro.is_colliding() and $Derecha.is_colliding():
		puedo_saltar = true
		if Input.is_action_just_pressed("ui_salto"):
			movimiento.y = -salto
			$SonidoSalto.play()
			$Anim.play("Salto")
	if Input.is_action_just_pressed("ui_salto"):
		if puedo_saltar and is_on_floor():
			movimiento.y = -salto
			snap = Vector2(0, 0)
			$TiempoSalto.start()
			$SonidoSalto.play()
			$Anim.play("Salto")
	if Input.is_action_pressed("ui_salto"):
		if not $TiempoSalto.is_stopped():
			movimiento.y = -aceleracion_salto


func _reacomodar() -> void:
	$SonidoMuerte.play()
	if muerto:
		set_physics_process(false)
		$Camera2D/AnimCam.play("Shake")
		$CollisionShape2D.call_deferred("disabled", true)
		$SprPlayer.hide()
		$ParticulasMuerte.emitting = true
		yield(get_tree().create_timer(1), "timeout")
		$SprPlayer.show()
		$CollisionShape2D.call_deferred("disabled", false)
		muerto = false
	position = coordenas_inicio
	vidas -= 1
	ControlJuego.emit_signal("jugador_acomodado")
	if vidas >= 1:
		set_physics_process(true)
		show()


func en_meta() -> void:
	set_physics_process(false)
