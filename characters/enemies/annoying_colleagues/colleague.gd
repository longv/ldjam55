extends CharacterBody2D

class_name ColleagueCombat

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var counter:int = 0
var atk_speed: int = 100
var tshirt_size: int = 9
var capacity: int = 10
var nickname: String = "Colleague"

@onready var anim = $AnimationPlayer
@onready var task_scene = load("res://objects/task.tscn")
@onready var task_appear: Node2D = $TaskAppear

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if position.x >= 877:
		velocity.x = -SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x > 0:
		anim.play("run")
	else:
		anim.play("idle")

	move_and_slide()

func _process(_delta):
	if capacity <= 0:
		SceneSwitcher.goto_previous(["Akabei", "Pinky"])
	counter += 1
	if int(counter) % atk_speed == 0:
		counter = 0
		send_task()

func send_task():
	var task: TaskCombat = task_scene.instantiate()
	task.position = task_appear.position
	task.speed = -800.0
	task.tshirt_size = tshirt_size
	call_deferred("add_child", task)

