extends Enemy


@export var start_delay = 5000

@onready var time_start = Time.get_ticks_msec()


func _should_begin():
	return true if Time.get_ticks_msec() - time_start > start_delay \
		else false
		
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
		SceneSwitcher.annoyance = "aosuke"
		SceneSwitcher.goto_scene("res://levels/meeting.tscn")	
