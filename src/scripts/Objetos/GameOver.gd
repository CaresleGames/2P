extends Label

func _ready() -> void:
	$".".hide()


func _on_Button_pressed() -> void:
	ControlJuego.emit_signal("reinicio")
