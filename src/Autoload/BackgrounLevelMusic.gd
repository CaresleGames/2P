extends AudioStreamPlayer

signal comienza_musica

var canciones := [
	load("res://assets/music/placeholder/musicaA.ogg"),
	load("res://assets/music/placeholder/musicaB.ogg"),
	load("res://assets/music/placeholder/Juhani Junkala [Retro Game Music Pack] Level 1.ogg"),
	load("res://assets/music/placeholder/Juhani Junkala [Retro Game Music Pack] Level 2.ogg"),
	load("res://assets/music/placeholder/Juhani Junkala [Retro Game Music Pack] Level 3.ogg"),
]
var emitir : bool = false
var cancion_actual : AudioStream

func _ready() -> void:
	cancion_actual = canciones[0]
	$".".stream = cancion_actual
	connect("comienza_musica", self, "_on_BackgroundMusic_comienza_musica")


func _process(_delta: float) -> void:
	if ControlJuego.inicio_juego and emitir == false:
		emitir = true
		emit_signal("comienza_musica")


func _on_BackgroundMusic_finished() -> void:
	cancion_actual = canciones[1]
	$".".stream = cancion_actual
	$Tween.interpolate_property(
			self, "volume_db", -80, 1, 0.2,
			Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	#play()
	$Tween.start()


func _on_BackgroundMusic_comienza_musica() -> void:
	#play()
	pass
