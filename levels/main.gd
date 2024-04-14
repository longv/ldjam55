extends Node2D

var counter: int = 0

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
	if SceneSwitcher.annoyance == "akabei":
		SceneSwitcher.annoyance = "pinky"
	elif SceneSwitcher.annoyance == "pinky":
		SceneSwitcher.annoyance = "aosuke"
	elif SceneSwitcher.annoyance == "aosuke":
		SceneSwitcher.annoyance = "guzuta"
	else:
		SceneSwitcher.annoyance = "akabei"
	SceneSwitcher.goto_scene("res://levels/meeting.tscn")	


func _on_play_mouse_entered():
	pass
