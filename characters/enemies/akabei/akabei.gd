extends Enemy


func _get_target_position():
	match current_mode:
		Mode.CHASE:
			return target.global_position
		_:
			return null
			
