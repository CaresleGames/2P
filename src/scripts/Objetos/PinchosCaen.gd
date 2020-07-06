extends KinematicBody2D

signal iniciar_timer

var movimiento := Vector2.ZERO
var timer_iniciado := false

onready var coordenas_inicio : Vector2 = $".".global_position


func _ready() -> void:
	connect("iniciar_timer", self, "_on_Iniciar_Timer")


func _physics_process(_delta: float) -> void:
	
	if $RayCast2D.is_colliding():
		$".".modulate = Colores.COLOR_ENEMIGO
		if not timer_iniciado:
			timer_iniciado = true
		$RayCast2D.enabled = false
		emit_signal("iniciar_timer")
	movimiento = move_and_slide(movimiento)


func _on_Timer_timeout() -> void:
	movimiento.y = 100


func _on_Muerte_body_entered(body: KinematicBody2D) -> void:
	if not body is KinematicBody2D:
		return
	$Muerte/CollisionShape2D.disabled = true
	if body.collision_layer == 1:
		set_process(false)
		body.muerto = true
		ControlJuego.emit_signal("reaparecer_inicio")
		


func _on_Iniciar_Timer() -> void:
	$Timer.start()


func _reacomodar() -> void:
	position = coordenas_inicio
	yield(get_tree().create_timer(.2), "timeout")
	$RayCast2D.enabled = true
	$".".modulate = Color(1, 1, 1, 1)
	$Muerte/CollisionShape2D.disabled = false
	set_process(true)
