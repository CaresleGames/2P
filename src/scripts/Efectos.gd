extends WorldEnvironment



func _ready() -> void:
	$".".environment = ControlJuego.environment_actual


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_glow_next"):
		ControlJuego.environment_actual = load("res://src/escenas/GlowEfectos/Efecto2.tres")
		$".".environment = ControlJuego.environment_actual
	if Input.is_action_just_pressed("ui_glow_prev"):
		ControlJuego.environment_actual = load("res://src/escenas/GlowEfectos/Efecto1.tres")
		$".".environment = ControlJuego.environment_actual
