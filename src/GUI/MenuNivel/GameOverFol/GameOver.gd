extends Label

var pantalla_gameover : bool = false

func _ready() -> void:
	$".".hide()
	$Button/Label.self_modulate = Colores.COLOR_JUGADOR


func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_salto") and pantalla_gameover:
		$Button.emit_signal("pressed")


func _on_Button_pressed() -> void:
	pantalla_gameover = false
	ControlJuego.emit_signal("reinicio")
