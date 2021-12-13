extends KinematicBody2D

signal iniciar_timer

var movimiento := Vector2.ZERO
var timer_iniciado := false

onready var coordenas_inicio : Vector2 = $".".position
onready var raycast_detector : RayCast2D = $Detector
onready var area_muerte : Area2D = $Muerte
onready var tiempo_espera : Timer = $Timer

func _ready() -> void:
	connect("iniciar_timer", self, "_on_Iniciar_Timer")


func _physics_process(_delta: float) -> void:
	
	if raycast_detector.is_colliding():
		$".".modulate = Colores.COLOR_ENEMIGO
		if not timer_iniciado:
			timer_iniciado = true
		raycast_detector.enabled = false
		emit_signal("iniciar_timer")
	movimiento = move_and_slide(movimiento, Actor.SUELO, true)


func _on_Timer_timeout() -> void:
	movimiento.y = 100


func _on_Muerte_body_entered(body: PhysicsBody2D) -> void:
	if not body is PhysicsBody2D:
		return
	if body is StaticBody2D:
		area_muerte.get_node("CollisionShape2D").call_deferred("disabled", true)
		area_muerte.set_deferred("monitoring", false)
	if body.collision_layer == 1:
		set_process(false)
		body.muerto = true
		ControlJuego.emit_signal("reaparecer_inicio")


func _on_Iniciar_Timer() -> void:
	tiempo_espera.start()


func _reacomodar() -> void:
	position = coordenas_inicio
	yield(get_tree().create_timer(.2), "timeout")
	raycast_detector.enabled = true
	area_muerte.get_node("CollisionShape2D").call_deferred("disabled", false)
	area_muerte.set_deferred("monitoring", true)
	$".".modulate = Color(1, 1, 1, 1)
	set_process(true)
