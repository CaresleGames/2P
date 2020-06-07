extends Label


func _ready() -> void:
	var texto := get_parent().name
	$".".text = texto
