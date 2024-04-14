extends Node2D


@export var scatter_interval: int = 10000
@export var scatter_duration: int = 5000

var scatter_time_start: int = -1
var normal_time_start: int = -1

@onready var enemies: Array[Enemy] = [$Akabei, $Pinky]


func _process(delta):
	if scatter_time_start == -1:
		var normal_time_elapsed = Time.get_ticks_msec() - normal_time_start
		if normal_time_elapsed > scatter_interval:
			for enemy in enemies:
				enemy.change_mode_to(Enemy.Mode.SCATTER)
			scatter_time_start = Time.get_ticks_msec()
	else:
		var scatter_time_elapsed = Time.get_ticks_msec() - scatter_time_start
		if (scatter_time_elapsed > scatter_duration):
			for enemy in enemies:
				enemy.change_mode_to(Enemy.Mode.CHASE)
			scatter_time_start = -1
			normal_time_start = Time.get_ticks_msec()
			
