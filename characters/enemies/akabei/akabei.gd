extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_tree = $AnimationTree


func _process(delta):
	_update_anim(velocity.normalized())

func _physics_process(delta):
	if velocity.y == 0:
		var h_direction = Input.get_axis("ui_left", "ui_right")
		if h_direction:
			velocity.x = h_direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x == 0:
		var v_direction = Input.get_axis("ui_up", "ui_down")
		if v_direction:
			velocity.y = v_direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _update_anim(direction: Vector2):
	if direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", direction)
