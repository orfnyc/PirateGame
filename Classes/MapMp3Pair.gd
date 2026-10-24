class_name MapMp3Pair
extends Object

var mp3: AudioStreamMP3
var map: Dictionary[float, int]
var num_beats: int
	
func _init(mp3_path: String, map_path: String, beats: int) -> void:
	mp3 = load(mp3_path)
	if not FileAccess.file_exists(map_path):
		return
	var file = FileAccess.open(map_path, FileAccess.READ)
	while file.get_position() < file.get_length():
		var line = file.get_line().split(" ")
		map[float(line[0])] = int(line[1])
	num_beats = beats
