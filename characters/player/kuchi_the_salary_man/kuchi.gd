extends CharacterBody2D

class_name Kuchi

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var capacity: int = 10

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var task_scene = load("res://objects/task.tscn")
@onready var task_appear: Node2D = $TaskAppear

func _ready():
	anim.play("idle")

func _physics_process(delta):
	if capacity <= 0:
		SceneSwitcher.goto_previous("KuchiNorm")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if position.x <= 275:
		velocity.x = SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x > 0:
		anim.play("run")
	else:
		anim.play("idle")

	move_and_slide()

func send_task(tshirt_size: int):
	print(position)
	var task: TaskCombat = task_scene.instantiate()
	task.position = task_appear.position
	task.tshirt_size = tshirt_size
	call_deferred("add_child", task)

