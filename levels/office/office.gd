extends Node2D


@export var scatter_interval: int = 10000
@export var scatter_duration: int = 5000
@export var frighted_duration: int = 5000

var scatter_time_start: int = -1
var frightened_time_start: int = -1
var normal_time_start: int = -1

@onready var enemies: Array[Enemy] = [$Akabei, $Pinky, $Aosuke, $Guzuta]


func _process(_delta):
	if frightened_time_start > 0:
		var frightened_time_elapsed = Time.get_ticks_msec() - frightened_time_start
		if frightened_time_elapsed > frighted_duration:
			for enemy in enemies:
				enemy.current_mode = Enemy.Mode.CHASE
			frightened_time_start = -1
			normal_time_start = Time.get_ticks_msec()
	elif scatter_time_start > 0:
		var scatter_time_elapsed = Time.get_ticks_msec() - scatter_time_start
		if scatter_time_elapsed > scatter_duration:
			for enemy in enemies:
				enemy.current_mode = Enemy.Mode.CHASE
			scatter_time_start = -1
			normal_time_start = Time.get_ticks_msec()
	else:
		var normal_time_elapsed = Time.get_ticks_msec() - normal_time_start
		if normal_time_elapsed > scatter_interval:
			for enemy in enemies:
				enemy.current_mode = Enemy.Mode.SCATTER
			scatter_time_start = Time.get_ticks_msec()
			
# TODO: Refactor
func _on_money_4_taken():
	for enemy in enemies:
		enemy.current_mode = Enemy.Mode.FRIGHTENED
	frightened_time_start = Time.get_ticks_msec()
	scatter_time_start = -1

func _on_money_3_taken():
	for enemy in enemies:
		enemy.current_mode = Enemy.Mode.FRIGHTENED
	frightened_time_start = Time.get_ticks_msec()
	scatter_time_start = -1

func _on_money_2_taken():
	for enemy in enemies:
		enemy.current_mode = Enemy.Mode.FRIGHTENED
	frightened_time_start = Time.get_ticks_msec()
	scatter_time_start = -1

func _on_money_taken():
	for enemy in enemies:
		enemy.current_mode = Enemy.Mode.FRIGHTENED
	frightened_time_start = Time.get_ticks_msec()
	scatter_time_start = -1

