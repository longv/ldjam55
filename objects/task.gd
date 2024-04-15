extends CharacterBody2D

class_name TaskCombat

var speed: float = 800.0
var timer: float = 4.0
var tshirt_size: int = 3
var counter: int = 0
var scaler: Vector2 = Vector2(1, 1)

@onready var character: CharacterBody2D = get_parent()
@onready var sprite: Sprite2D = $Shape/Sprite
@onready var computer = load("res://objects/assets/computer.png")
@onready var fax = load("res://objects/assets/fax.png")
@onready var money_pile = load("res://objects/assets/money_pile.png")
@onready var presentation = load("res://objects/assets/presentation.png")
@onready var task_pile = load("res://objects/assets/task_pile.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = speed
	if tshirt_size <= 3:
		if randi_range(0, 1) == 0:
			sprite.texture = task_pile
		else:
			sprite.texture = computer
	elif tshirt_size <= 5:
		sprite.texture = fax
	elif tshirt_size <= 7:
		sprite.texture = presentation
	else:
		sprite.texture = money_pile

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += 1
	if tshirt_size <= 0:
		queue_free()
	# Force keep scale to 1
	# if scale.x != 1 || scale.y != 1:
	# if counter % 10 == 0 && scale.x <= float(tshirt_size) / 3:
	if counter % 10 == 0 && scale.x <= 2:
		scaler = Vector2(scale.x + 0.1, scale.y + 0.1)
	scale = scaler
	timer -= delta
	if timer <= 0 || \
		position.x > ((1150.0 - character.position.x) / character.scale.x):
		queue_free()
	

func _physics_process(_delta):
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D):
	body.capacity -= tshirt_size
	if body.name == "Colleague" || body.name == "Kuchi":
		queue_free()
	if body.name == "Kuchi":
		$"../../Left/Capacity/Score".text = "[center]%d[/center]" % body.capacity
	else:
		$"../../Right/Capacity/Score".text = "[center]%d[/center]" % body.capacity
		


func _on_hitbox_area_entered(area: Area2D):
	if area.name == "Hitbox" && character.name == "Kuchi":
		var own_size = tshirt_size
		var foreign_size = area.get_parent().tshirt_size
		tshirt_size -= foreign_size
		area.get_parent().tshirt_size = foreign_size - own_size
		if tshirt_size <= 0:
			queue_free()

