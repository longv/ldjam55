extends ColleagueCombat


func _ready():
	atk_speed = _atk_speed()
	tshirt_size = _dmg()

func send_task():
	super.send_task()
	atk_speed = _atk_speed()
	tshirt_size = _dmg()

func _atk_speed():
	return randi_range(3, 5) * 100

func _dmg():
	return randi_range(1, 3)

