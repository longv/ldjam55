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

## Number of seconds delay before new task is given
@onready var task_delay: float = DELAY
@onready var is_done: bool = false
@onready var kuchi: CharacterBody2D = get_node("Kuchi")

# Called when the node enters the scene tree for the first time.
func _ready():
	if vim_mode:
		acceptable_input = CHAD_INPUTS
	else:
		acceptable_input = CONVENTIONAL_INPUTS
	print("Acceptable inputs:")
	_print_keys_name(acceptable_input)
	task = _get_new_task()
	print(get_tree().current_scene)
	print("res://characters/enemies/annoying_colleagues/%s.tscn" % SceneSwitcher.annoyance)
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
	

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE:
			_print_keys_name(work)
			if _is_work_correct(work, task, true):
				print("Task completed successfully")
				is_done = true
				kuchi.send_task()
			work.clear()
			return
		if acceptable_input.has(event.keycode):
			work.append(event.keycode)
			if not _is_work_correct(work, task):
				print("Wrong step")
				work.clear()
		else:
			print("Input string is broken")
			work.clear()

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
func _is_work_correct(w: Array[int], t: Array[int], strict: bool = false) -> bool:
	if strict && w.size() != t.size():
		return false
	if w.size() > t.size():
		return false
	for i in w.size():
		if w[i] != t[i]:
			return false
	return true

