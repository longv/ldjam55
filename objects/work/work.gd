extends StaticBody2D
class_name Work


signal taken


func _ready():
	$AnimationPlayer.play("idle")

func _on_hitbox_body_entered(body: Node2D):
	if body is KuchiNorm:
		body.work_piles.append(self)
		taken.emit()
		queue_free()
