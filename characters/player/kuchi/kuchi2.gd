extends CharacterBody2D


@export var speed = 300.0

@onready var anim_tree = $AnimationTree


func _process(delta):
	_update_anim()

func _physics_process(delta):
	var h_direction = Input.get_axis("ui_left", "ui_right")
	if h_direction && velocity.y == 0:
		velocity.x = h_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	var v_direction = Input.get_axis("ui_up", "ui_down")
	if v_direction && velocity.x == 0:
		velocity.y = v_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

func _update_anim():
	if velocity != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = velocity.normalized()
		anim_tree["parameters/Run/blend_position"] = velocity.normalized()

	anim_tree["parameters/conditions/idling"] = velocity == Vector2.ZERO
	anim_tree["parameters/conditions/moving"] = velocity != Vector2.ZERO
