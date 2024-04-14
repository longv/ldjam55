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
			
