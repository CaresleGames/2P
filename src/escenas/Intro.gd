extends Node2D

func _ready() -> void:
	yield(get_tree().create_timer(.5), "timeout")
	$Anim.play("Intro")
