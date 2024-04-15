extends Enemy


func _get_target_position():
	match current_mode:
		Mode.CHASE:
			return target.global_position
		Mode.SCATTER:
			return Vector2(64, 64)
		Mode.FRIGHTENED:
			return null
		_:
			return null

func _on_hitbox_body_entered(body: Node2D):
	if body is KuchiNorm:
		SceneSwitcher.annoyance = "akabei"
		SceneSwitcher.goto_scene("res://levels/meeting.tscn")	
