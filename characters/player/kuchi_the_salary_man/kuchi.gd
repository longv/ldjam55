extends CharacterBody2D

enum STATE {IDLE}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")
@onready var state = STATE.IDLE
@onready var task_scene = load("res://objects/task.tscn")
@onready var task_appear: Node2D = get_node("TaskAppear")

func _ready():
	anim.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# # Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY
	#
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction = Input.get_axis("ui_left", "ui_right")
	# if direction:
	if position.x <= 275:
		velocity.x = SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x > 0:
		anim.play("run")
	else:
		anim.play("idle")

	move_and_slide()

func send_task():
	print(position)
	var task = task_scene.instantiate()
	task.position = task_appear.position
	call_deferred("add_child", task)