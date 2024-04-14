extends Enemy


func _get_target_position():
	match current_mode:
		Mode.CHASE:
			var next_tile_position = target.velocity.normalized() * 180 # Two tiles ahead of target.
			return target.global_position + next_tile_position
		_:
			return null
