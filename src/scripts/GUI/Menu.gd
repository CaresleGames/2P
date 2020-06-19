extends Control

export var siguiente_escena : PackedScene

var boton_selecionado : int = 0 # 0 Iniciar 1 Salir

onready var anim : AnimationPlayer = $Transicion/AnimationPlayer

func _ready() -> void:
	$Transicion.hide()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		if boton_selecionado == 0:
			boton_selecionado = 1
		else:
			boton_selecionado = 0
	if Input.is_action_just_pressed("ui_left"):
		if boton_selecionado == 1:
			boton_selecionado = 0
		else:
			boton_selecionado = 1
	
	if Input.is_action_just_pressed("ui_salto") and boton_selecionado == 0:
		$Iniciar.emit_signal("pressed")
	if Input.is_action_just_pressed("ui_salto") and boton_selecionado == 1:
		$Salir.emit_signal("pressed")
	
 

func _on_Iniciar_pressed() -> void:
	$Transicion.show()
	anim.play("Entrada")
	yield(anim, "animation_finished")
	anim.play("Salida")
	yield(anim, "animation_finished")
	yield(get_tree().create_timer(.001), "timeout")
	get_tree().change_scene_to(siguiente_escena)
	ControlJuego.inicio_juego = true


func _on_Salir_pressed() -> void:
	get_tree().quit()
