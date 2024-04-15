extends Enemy


@export var start_delay = 5000

@onready var time_start = Time.get_ticks_msec()


func _should_begin():
	return true if Time.get_ticks_msec() - time_start > start_delay \
		else false
		
func _get_target_position():
	match current_mode:
		Mode.CHASE: # Go after Kuchi two tiles.
			var next_tile_position = target.velocity.normalized() * 180
			return target.global_position - next_tile_position
		Mode.SCATTER:
			var dest = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
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
			SceneSwitcher.annoyance = "aosuke"
			SceneSwitcher.goto_scene("res://levels/meeting.tscn")	
