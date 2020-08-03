extends Node2D

export var menu : PackedScene


func _ready() -> void:
	yield(get_tree().create_timer(.5), "timeout")
	$Anim.play("Intro")


func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_salto"):
		$Anim.play("Salida")


func _on_Anim_animation_finished(anim_name: String) -> void:
	if anim_name == "Salida":
		print("Salida")
		get_tree().change_scene_to(menu)
