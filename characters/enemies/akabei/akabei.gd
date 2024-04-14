extends CharacterBody2D


@export var speed = 300.0
@export var acceleration = 7

@onready var target = %KuchiNorm
@onready var anim_tree = $AnimationTree
@onready var nav_agent = $Navigation/NavigationAgent2D


func _process(_delta):
	_update_anim()

func _physics_process(delta):
	var direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.lerp(direction * speed, acceleration * delta)

	move_and_slide()

func _update_anim():
	if velocity != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = velocity.normalized()
		anim_tree["parameters/Run/blend_position"] = velocity.normalized()

	anim_tree["parameters/conditions/idling"] = velocity == Vector2.ZERO
	anim_tree["parameters/conditions/moving"] = velocity != Vector2.ZERO


func _on_timer_timeout():
	nav_agent.target_position = target.global_position
