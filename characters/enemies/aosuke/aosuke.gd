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
			return null
		_:
			return null

func _on_hitbox_body_entered(body: Node2D):
	if body is KuchiNorm:
		SceneSwitcher.annoyance = "aosuke"
		SceneSwitcher.goto_scene("res://levels/meeting.tscn")	
