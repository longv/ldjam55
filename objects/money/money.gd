extends StaticBody2D
class_name Money


func _on_hitbox_body_entered(body: Node2D):
	if body is KuchiNorm:
		body.money_piles.append(self)
		queue_free()
