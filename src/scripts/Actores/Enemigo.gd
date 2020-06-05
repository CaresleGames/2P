extends Actor


func _physics_process(_delta: float) -> void: 
	movimiento.x = max(movimiento.x - aceleracion, -velocidad)
	
	movimiento = move_and_slide(movimiento, SUELO)
