class_name MapMp3Pair
extends Object

var mp3: Resource
var map: Resource
	
func _init(mp3_path: String, map_path: String) -> void:
	mp3 = load(mp3_path)
	map = load(map_path)
