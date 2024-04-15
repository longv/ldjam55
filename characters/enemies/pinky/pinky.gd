extends Enemy


@export var work_piles_taken_threshold = 3


func _should_begin():
	return true if target.work_piles.size() >= work_piles_taken_threshold \
		else false

func _get_target_position():
	match current_mode:
		Mode.CHASE:
			var next_tile_position = target.velocity.normalized() * 180 # Two tiles ahead of target.
			return target.global_position + next_tile_position
		Mode.SCATTER:
			var dest = Vector2(get_viewport_rect().size.x, 0)
			return dest
		_:
			return null

func _on_hitbox_body_entered(body: Node2D):
	if body is KuchiNorm:
		SceneSwitcher.annoyance = "pinky"
		SceneSwitcher.goto_scene("res://levels/meeting.tscn")	
