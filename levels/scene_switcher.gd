extends Node

var current_scene = null
var previous_scene = null
var annoyance: String = "colleague"

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# Store current scene ref
	previous_scene = current_scene
	get_tree().root.remove_child(previous_scene)

	# Load the new scene.
	current_scene = ResourceLoader.load(path).instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene


func goto_previous(characters: Array[String]):
	call_deferred("_deferred_goto_previous", characters)


func _deferred_goto_previous(characters: Array[String]):
	# Free meeting
	current_scene.free()
	print(characters)
	for character in characters:
		var loser = previous_scene.get_node(character)
		loser.global_position = loser.home.global_position
	# Add back the previous scene to root
	get_tree().root.add_child(previous_scene)
	# Set tree current scene to the previous scene
	get_tree().current_scene = previous_scene
	# Set current scene and free ref
	current_scene = previous_scene
	previous_scene = null

