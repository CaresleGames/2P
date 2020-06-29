extends WorldEnvironment


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_glow_next"):
		$".".environment = load("res://src/escenas/GlowEfectos/Efecto2.tres")
	if Input.is_action_just_pressed("ui_glow_prev"):
		$".".environment = load("res://src/escenas/GlowEfectos/Efecto1.tres")
