extends Enemy


func _get_target_position():
	match current_mode:
		Mode.CHASE:
			return target.global_position
		Mode.SCATTER:
			var dest = Vector2(0, get_viewport_rect().size.y)
			return dest
		Mode.FRIGHTENED:
			return null
		_:
			return null

func _on_hitbox_body_entered(body: Node2D):
	if body is KuchiNorm:
		SceneSwitcher.annoyance = "guzuta"
		SceneSwitcher.goto_scene("res://levels/meeting.tscn")	
