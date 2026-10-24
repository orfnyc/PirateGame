extends Node2D

const NOTE = preload("uid://djord860u55gt")

@onready var notes_folder: Node = $NotesFolder
@onready var conductor: AudioStreamPlayer = $Conductor
@onready var buttons: Dictionary[int, Node2D] = {
	1: $ButtonsFolder/Middle,
	2: $ButtonsFolder/Top,
	3: $ButtonsFolder/Left,
	4: $ButtonsFolder/Right,
	5: $ButtonsFolder/Bottom
}

var score: int = 0

var notes_data: Dictionary[float, int] = {}

func _ready() -> void:
	# generate song from clip graph
	# collect notes from song into array
	load_text_file("res://Assets/MapFiles/Leave-Her-Johnny.txt")
	conductor.play_with_beat_offset(2)

func load_text_file(file_path: String):
	if not FileAccess.file_exists(file_path):
		return
	var file = FileAccess.open(file_path, FileAccess.READ)
	while file.get_position() < file.get_length():
		var line = file.get_line().split(" ")
		notes_data[float(line[0])] = int(line[1])

func increment_score(val: int):
	score += val

func _on_conductor_beat(position: float) -> void:
	position = position / 4 + 1
	if notes_data.has(position):
		var new_note: Note = NOTE.instantiate()
		new_note.init_note(buttons[notes_data[position]].position)
		new_note.connect("increment_score", increment_score)
		notes_folder.add_child(new_note)

func _draw() -> void:
	for i in range(1,6):
		draw_arc(buttons[i].position, 40, 0, TAU, 100, Color.WHITE)
