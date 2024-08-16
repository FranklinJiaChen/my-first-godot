extends Node

const SAVE_PATH = "res://savegame.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"high_score" = Game.high_score
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.high_score = current_line["high_score"]
	else:
		print("file does not exist")
