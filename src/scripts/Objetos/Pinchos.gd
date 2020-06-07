extends Area2D



func _on_Pinchos_body_entered(body: KinematicBody2D) -> void:
	if body.collision_layer == 4:
		body.hide()
		body.muerte_pinchos()
		return
	body._reacomodar()
	var enemigo = get_tree().get_nodes_in_group("enemigo")
	
	for e in enemigo:
		e._reacomodar()
