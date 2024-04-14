extends CharacterBody2D

const SPEED: float = 800.0

var timer: float = 4.0

@onready var character: CharacterBody2D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Force keep scale to 1
	if scale.x != 1 || scale.y != 1:
		scale = Vector2(1, 1)
	timer -= delta
	if timer <= 0 || \
		position.x > ((1150.0 - character.position.x) / character.scale.x):
		queue_free()
	

func _physics_process(_delta):
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D):
	if body.name == "Colleague":
		# TODO: Change this
		# SceneSwitcher.goto_previous()
		queue_free()
	# var parent = area.get_parent()
	# if !is_dead && area.name == "Hitbox" && parent.name == "Player":
	# 	# Bounce player up a bit
	# 	parent.velocity.y = JUMP_VELOCITY
	# 	# Play death
	# 	is_dead = true

