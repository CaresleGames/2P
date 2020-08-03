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
var puedo_mover := false

onready var sonido_salto : AudioStreamPlayer = $Sonidos/SonidoSalto
onready var sonido_muerte : AudioStreamPlayer = $Sonidos/SonidoMuerte
onready var raycast_izquierdo : RayCast2D = $RaycastPlayer/Izquierda
onready var raycast_centro : RayCast2D = $RaycastPlayer/Centro
onready var raycast_derecha : RayCast2D = $RaycastPlayer/Derecha
onready var timer_coyote_jump : Timer = $Timers/CoyoteJump
onready var timer_tiempo_salto : Timer = $Timers/TiempoSalto


func _ready() -> void:
	$".".connect("llegue_meta", self, "en_meta")


func _physics_process(_delta: float) -> void:
	if puedo_mover:
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
	raycast_izquierdo.force_raycast_update()
	raycast_centro.force_raycast_update()
	raycast_derecha.force_raycast_update()
	movimiento = move_and_slide_with_snap(movimiento,
			 snap, SUELO, true, 4, angulo, false)  


func mover_y() -> void:
	if not is_on_floor():
		movimiento.y += gravedad * get_physics_process_delta_time()

	if is_on_floor():
		movimiento.y = 0
		snap = Vector2(0, 16)
		puedo_saltar = true
	
	if not is_on_floor() and raycast_izquierdo.is_colliding() and not raycast_centro.is_colliding() and not raycast_derecha.is_colliding() and not is_on_wall():
		timer_coyote_jump.start()
	if not is_on_floor() and not raycast_izquierdo.is_colliding() and not raycast_centro.is_colliding() and raycast_derecha.is_colliding() and not is_on_wall():
		timer_coyote_jump.start()
		
	if not timer_coyote_jump.is_stopped():
		if Input.is_action_just_pressed("ui_salto"):
			movimiento.y = -salto
			timer_coyote_jump.stop()
	if raycast_izquierdo.is_colliding() and raycast_centro.is_colliding() and raycast_derecha.is_colliding():
		puedo_saltar = true
		if Input.is_action_just_pressed("ui_salto"):
			movimiento.y = -salto
			sonido_salto.play()
			$Anim.play("Salto")
	if Input.is_action_just_pressed("ui_salto"):
		if puedo_saltar and is_on_floor():
			movimiento.y = -salto
			snap = Vector2(0, 0)
			timer_tiempo_salto.start()
			sonido_salto.play()
			$Anim.play("Salto")
	if Input.is_action_pressed("ui_salto"):
		if not timer_tiempo_salto.is_stopped():
			movimiento.y = -aceleracion_salto


func _reacomodar() -> void:
	sonido_muerte.play()
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
	$Camera2D.emit_signal("zoom_out")
	set_physics_process(false)
