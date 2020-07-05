extends KinematicBody2D

var movimiento := Vector2.ZERO


func _physics_process(_delta: float) -> void:
	
	if $RayCast2D.is_colliding():
		print('Colliding')
		$".".modulate = Colores.COLOR_ENEMIGO
		$Timer.start()
	movimiento = move_and_slide(movimiento)


func _on_Timer_timeout() -> void:
	print('Caida')
	movimiento.y = 100
