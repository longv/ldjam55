extends CharacterBody2D
class_name KuchiNorm


@export var speed = 300.0
@export var accelaration = 7.0

var work_piles: Array[Work] = []
var money_piles: Array[Money] = []

@onready var anim_tree = $AnimationTree


func _process(_delta):
	_update_anim()

func _physics_process(delta):
	var direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accelaration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()

func _update_anim():
	if velocity != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = velocity.normalized()
		anim_tree["parameters/Run/blend_position"] = velocity.normalized()

	anim_tree["parameters/conditions/idling"] = velocity == Vector2.ZERO
	anim_tree["parameters/conditions/moving"] = velocity != Vector2.ZERO
