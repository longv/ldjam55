extends Node2D

var counter: int = 0

@onready var play: TextureButton = $Play

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	counter += 1
	if int(counter) % 100 == 0:
		print(counter)


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	# get_tree().change_scene_to_file("res://levels/meeting.tscn")
	# var s = ResourceLoader.load("res://levels/meeting.tscn")
	SceneSwitcher.goto_scene("res://levels/office/office.tscn")	


func _on_play_mouse_entered():
	play.scale = Vector2(3.5, 3.5)


func _on_play_mouse_exited():
	play.scale = Vector2(3, 3)

