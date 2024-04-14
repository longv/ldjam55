extends Node2D

const CONVENTIONAL_INPUTS: Array[int] = [KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT]
const CHAD_INPUTS: Array[int] = [KEY_K, KEY_J, KEY_H, KEY_L]
const DELAY: float = 1
const TASK_LENGTHS: Array[int] = [3, 5, 7, 9]

## Enable to use glorious vim motion to complete tasks
var vim_mode: bool = false

## Number of acceptable length
var task: Array[int] = []
var work: Array[int] = []
var acceptable_input: Array[int] = []
var key_map = {}

## Number of seconds delay before new task is given
@onready var task_delay: float = DELAY
@onready var is_done: bool = true
@onready var kuchi: CharacterBody2D = get_node("Kuchi")
@onready var task_hud: CanvasLayer = get_node("TaskHud")

# Called when the node enters the scene tree for the first time.
func _ready():
	if vim_mode:
		acceptable_input = CHAD_INPUTS
		key_map = {
			"K": load("res://ui/hud/assets/keyboard_k.png"),
			"J": load("res://ui/hud/assets/keyboard_j.png"),
			"H": load("res://ui/hud/assets/keyboard_h.png"),
			"L": load("res://ui/hud/assets/keyboard_l.png"),
		}
	else:
		acceptable_input = CONVENTIONAL_INPUTS
		key_map = {
			"Up": load("res://ui/hud/assets/keyboard_arrow_up.png"),
			"Down": load("res://ui/hud/assets/keyboard_arrow_down.png"),
			"Left": load("res://ui/hud/assets/keyboard_arrow_left.png"),
			"Right": load("res://ui/hud/assets/keyboard_arrow_right.png"),
		}

	## Instantiate tasks
	print("Acceptable inputs:")
	_print_keys_name(acceptable_input)
	# task = _get_new_task()
	# _handle_task_hud(task_hud, task, work)


	## Add enemy dynamically
	var enemy = load("res://characters/enemies/annoying_colleagues/%s.tscn" % SceneSwitcher.annoyance).instantiate()
	enemy.position = Vector2(1062, 0)
	enemy.scale = Vector2(5, 5)
	call_deferred("add_child", enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_done:
		task_delay -= delta
	if is_done && task_delay <= 0:
		task = _get_new_task()
		task_delay = DELAY
		is_done = false
		_handle_task_hud()
	

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE:
			_print_keys_name(work)
			if _is_work_correct(true):
				print("Task completed successfully")
				is_done = true
				kuchi.send_task()
				_clear_task_hud()
			work.clear()
		elif acceptable_input.has(event.keycode):
			work.append(event.keycode)
			# if not _is_work_correct():
			# 	print("Wrong step")
			# 	work.clear()
			# call_deferred("_handle_task_hud", task_hud, task, work)
		else:
			print("Illegal input")
			# work.clear()
		_handle_task_hud()

## Print human readable name of the keycodes
func _print_keys_name(keys: Array[int]):
	print(keys.map(func(key): return OS.get_keycode_string(key)))

## Get a new task
func _get_new_task() -> Array[int]:
	var new_task: Array[int] = []
	for _i in range(TASK_LENGTHS[randi_range(0, 3)]):
		new_task.append(acceptable_input[randi_range(0, 3)])
	print("Given tasks:")
	_print_keys_name(new_task)
	return new_task

## Compare work so far if it's still correct according to the given task
func _is_work_correct(strict: bool = false) -> bool:
	if strict && work.size() != task.size():
		return false
	if work.size() > task.size():
		return false
	for i in work.size():
		if work[i] != task[i]:
			return false
	return true

func _handle_task_hud():
	if is_done:
		return
	var left_over = (9.0 - task.size()) / 2.0
	var children = task_hud.get_children()
	for i in task_hud.get_child_count():
		if i < left_over || i >= task.size() + left_over:
			children[i].visible = false
		else:
			children[i].visible = true
			children[i].texture = key_map[OS.get_keycode_string(task[i - left_over])]
			if i  - left_over < work.size() && task[i - left_over] == work[i - left_over]:
				children[i].modulate = Color(0, 1, 0, 1)
			elif i  - left_over < work.size() && task[i - left_over] != work[i - left_over]:
				children[i].modulate = Color(1, 0, 0, 1)
			else:
				children[i].modulate = Color(1, 1, 1, 1)

func _clear_task_hud():
	if not is_done:
		return
	for child in task_hud.get_children():
		child.visible = false

