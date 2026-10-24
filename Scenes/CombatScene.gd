extends Node2D

const NOTE = preload("uid://djord860u55gt")

@onready var notes_folder: Node = $NotesFolder
@onready var conductor: AudioStreamPlayer = $Conductor
@onready var buttons: Dictionary[int, Node2D] = {
	2: $ButtonsFolder/Middle,
	4: $ButtonsFolder/Top,
	1: $ButtonsFolder/Left,
	3: $ButtonsFolder/Right,
	5: $ButtonsFolder/Bottom
}

@onready var notes_folders: Dictionary[int, Node] = {
	2: $NotesFolder/Middle,
	4: $NotesFolder/Top,
	1: $NotesFolder/Left,
	3: $NotesFolder/Right,
	5: $NotesFolder/Bottom
}
@onready var ui: Control = $UI

var inputs: Dictionary[int, String] = {
	1: 'A',
	2: 'S',
	3: 'D',
	4: 'W',
	5: 'space'
}

var score: int = 0
var playlist_array: Array[AudioStreamMP3] = []
var playlist_index: int = 0
var notes_data: Dictionary[float, int] = {}

var combo: int = 0

func _ready() -> void:
	# generate song from clip graph
	# collect notes from song into array
	build_playlist()
	conductor.play()


func build_playlist() -> void:
	var songs_array: Array[MapMp3Pair] = [SongLinksGraph.SONGS["Drunken-Sailor"],
											SongLinksGraph.SONGS["Leave-Her"]]
	var playlist := AudioStreamPlaylist.new()
	playlist.stream_count = songs_array.size()
	playlist.fade_time = 0
	playlist.loop = false
	var beats_count = 0
	for i in range(songs_array.size()):
		playlist.set_list_stream(i, songs_array[i].mp3)
		for key in songs_array[i].map:
			notes_data[key + beats_count] = songs_array[i].map[key]
		beats_count += songs_array[i].num_beats
	conductor.stream = playlist

func increment_score(val: int):
	score += val

func _on_conductor_beat(pos: float) -> void:
	pos = pos / 4 + 1
	if notes_data.has(pos):
		var new_note: Note = NOTE.instantiate()
		new_note.init_note(buttons[notes_data[pos]].position, inputs[notes_data[pos]])
		new_note.connect("clicked", evaluate_for_removal)
		notes_folders[notes_data[pos]].add_child(new_note)

func evaluate_for_removal(note: Note, status: String, early: bool):
	var others_at_position: Array[Node] = note.get_parent().get_children()
	if note == others_at_position[0]:
		var delta_score = 0
		if status == "total miss":
			delta_score = -2
		elif status == "miss":
			delta_score = -1
		elif status == "okay":
			delta_score = 1
		elif status == "good":
			delta_score = 2
		elif status == "perfect":
			delta_score = 3
		elif status == "true perfect":
			delta_score = 5
		if delta_score >= 2:
			combo += 1
		else:
			combo = 0
		if combo >= 32:
			delta_score *= 8
		elif combo >= 8:
			delta_score *= 4
		elif combo >= 2:
			delta_score *= 2
		score += delta_score
		if status == "true perfect":
			print("true perfect!")
		else:
			print(("Early" if early else "Late") + " " + status)
		ui.update_score(score)
		note.queue_free()

func _draw() -> void:
	for i in range(1,6):
		draw_arc(buttons[i].position, 20, 0, TAU, 100, Color.WHITE)
