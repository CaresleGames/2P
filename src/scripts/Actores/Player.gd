extends KinematicBody2D



func _ready() -> void:
	$".".modulate = Colores.COLOR_JUGADOR


func _physics_process(delta: float) -> void:
	var m = move_and_slide(Vector2(10, 0), Vector2.UP)
