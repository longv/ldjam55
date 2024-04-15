extends Enemy


@export var work_piles_taken_threshold = 3


func _should_begin():
	return true if target.work_piles.size() >= work_piles_taken_threshold \
		else false

func _get_target_position():
	match current_mode:
		Mode.CHASE: # Go ahead of Kuchi two tiles.
			var next_tile_position = target.velocity.normalized() * 180
			return target.global_position + next_tile_position
		Mode.SCATTER:
			var dest = Vector2(get_viewport_rect().size.x, 0)
			return dest
		Mode.FRIGHTENED:
			var x = random_number_gen.randf_range(get_viewport_rect().size.x, get_viewport_rect().size.y)
			var y = random_number_gen.randf_range(get_viewport_rect().size.x, get_viewport_rect().size.y)
			return Vector2(x, y)
		_:
			return null

func _on_hitbox_body_entered(body: Node2D):
	if body is KuchiNorm:
		if current_mode == Mode.FRIGHTENED:
			global_position = home.global_position
		else:
			SceneSwitcher.annoyance = "pinky"
			SceneSwitcher.goto_scene("res://levels/meeting.tscn")	
