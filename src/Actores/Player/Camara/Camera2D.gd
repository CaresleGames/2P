extends Camera2D

signal zoom_out

func _ready() -> void:
	$".".zoom = Vector2(1, 1)
	connect("zoom_out", self, "_en_zoom_out")


func _en_zoom_out() -> void:
	$Tween.interpolate_property(self, "zoom", Vector2(1, 1),
			Vector2(0.25, 0.25), .5, 
			Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
