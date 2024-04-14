extends ColleagueCombat

 
func _ready():
	atk_speed = 650
	tshirt_size = _dmg()

func send_task():
	super.send_task()
	tshirt_size = _dmg()

func _dmg():
	return randi_range(3, 5)

