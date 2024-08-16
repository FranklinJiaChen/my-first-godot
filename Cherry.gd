extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		Game.score += 1
		var tween_pos = get_tree().create_tween()
		tween_pos.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		var tween_vis = get_tree().create_tween()
		tween_vis.tween_property(self, "modulate:a", 0, 0.2)
		tween_pos.tween_callback(queue_free)
		tween_vis.tween_callback(queue_free)
