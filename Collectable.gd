extends Node


var Cherry = preload("res://Cherry.tscn")

func _on_timer_timeout():
	var cherryTemp = Cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	var randint = rng.randi_range(25, 1125)
	cherryTemp.position = Vector2(randint,521)
	add_child(cherryTemp)
