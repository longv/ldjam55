extends CharacterBody2D

class_name TaskCombat

var speed: float = 800.0
var timer: float = 4.0
var tshirt_size: int = 3

@onready var character: CharacterBody2D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tshirt_size <= 0:
		queue_free()
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
	body.capacity -= tshirt_size
	if body.name == "Colleague" || body.name == "Kuchi":
		queue_free()


func _on_hitbox_area_entered(area: Area2D):
	if area.name == "Hitbox" && character.name == "Kuchi":
		var own_size = tshirt_size
		var foreign_size = area.get_parent().tshirt_size
		tshirt_size -= foreign_size
		area.get_parent().tshirt_size = foreign_size - own_size
		if tshirt_size <= 0:
			queue_free()

