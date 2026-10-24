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

@onready var notes_folders: Dictionary[int, Node] = {
	1: $NotesFolder/Middle,
	2: $NotesFolder/Top,
	3: $NotesFolder/Left,
	4: $NotesFolder/Right,
	5: $NotesFolder/Bottom
}

var inputs: Dictionary[int, String] = {
	1: 'S',
	2: 'W',
	3: 'A',
	4: 'D',
	5: 'space'
}

var score: int = 0

var notes_data: Dictionary[float, int] = {}

func _ready() -> void:
	# generate song from clip graph
	# collect notes from song into array
	load_text_file("res://Assets/MapFiles/Connector-1.txt")
	conductor.play_with_beat_offset(0)

#func build_playlist() -> void:
	#var playlist: AudioStreamPlaylist = 
	#pass

func load_text_file(file_path: String):
	if not FileAccess.file_exists(file_path):
		return
	var file = FileAccess.open(file_path, FileAccess.READ)
	while file.get_position() < file.get_length():
		var line = file.get_line().split(" ")
		notes_data[float(line[0])] = int(line[1])

func increment_score(val: int):
	score += val

func _on_conductor_beat(pos: float) -> void:
	pos = pos / 4 + 1
	if notes_data.has(pos):
		var new_note: Note = NOTE.instantiate()
		new_note.init_note(buttons[notes_data[pos]].position, inputs[notes_data[pos]])
		new_note.connect("clicked", evaluate_for_removal)
		notes_folders[notes_data[pos]].add_child(new_note)

func evaluate_for_removal(note: Note, status: String):
	var others_at_position: Array[Node] = note.get_parent().get_children()
	if note == others_at_position[0]:
		print(status)
		note.queue_free()

func _draw() -> void:
	for i in range(1,6):
		draw_arc(buttons[i].position, 40, 0, TAU, 100, Color.WHITE)
