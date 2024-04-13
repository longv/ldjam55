extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_tree = $AnimationTree


func _process(delta):
	_update_anim()

func _physics_process(delta):
	var h_direction = Input.get_axis("ui_left", "ui_right")
	if h_direction && velocity.y == 0:
		velocity.x = h_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var v_direction = Input.get_axis("ui_up", "ui_down")
	if v_direction && velocity.x == 0:
		velocity.y = v_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _update_anim():
	if velocity != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = velocity.normalized()
		anim_tree["parameters/Run/blend_position"] = velocity.normalized()

	anim_tree["parameters/conditions/idling"] = velocity == Vector2.ZERO
	anim_tree["parameters/conditions/moving"] = velocity != Vector2.ZERO
