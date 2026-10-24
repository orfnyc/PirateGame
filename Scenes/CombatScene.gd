extends Node2D

const NOTE = preload("uid://djord860u55gt")

@onready var notes_folder: Node = $NotesFolder

var score: int = 0

func _ready() -> void:
	# generate song from clip graph
	
	# collect notes from song into array
	load_text_file("res://Assets/MapFiles/sample_song.txt")
	# testing note spawn
	var new_note: Note = NOTE.instantiate()
	new_note.init_note(Vector2(150,250), "A")
	new_note.connect("increment_score", increment_score)
	notes_folder.add_child(new_note)

func load_text_file(file_path: String):
	if not FileAccess.file_exists(file_path):
		return
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	print(content)

func increment_score(val: int):
	score += val

#@onready var song_data: AnimationPlayer = $SongData
#@onready var buttons: Array[Sprite2D] = [$"0",$"1",$"2",$"3",$"4"]
#
#const NOTE_WARNING: float = 0.5
#const LENIENCY: float = 0.05
#
#var open_windows: Array[Dictionary] = []
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#load_inputs()
#
#func load_inputs() -> void:
	#song_data.stop()
	#var anim: Animation = song_data.get_animation("SampleSong")
	#var track_num = 1
	#var open_window_num = anim.add_track(Animation.TYPE_METHOD)
	#anim.track_set_path(open_window_num, anim.track_get_path(track_num))
	#
	#var warning_num = anim.add_track(Animation.TYPE_METHOD)
	#anim.track_set_path(warning_num, anim.track_get_path(track_num))
	#
	#var key_count = anim.track_get_key_count(track_num)
	#for key_i in range(key_count):
		#var key_time = anim.track_get_key_time(track_num, key_i)
		#var key_value = anim.track_get_key_value(track_num, key_i)
		#var new_method = {
			#"method": "open_window",
			#"args": [key_value.args[0], key_value.args[1]]
		#}
		#var new_method2 = {
			#"method": "show_warning",
			#"args": [key_value.args[0], key_value.args[1]]
		#}
		#anim.track_insert_key(open_window_num, max(0,key_time-LENIENCY), new_method)
		#anim.track_insert_key(warning_num, max(0,key_time-NOTE_WARNING), new_method2)
	#print(anim.get_track_count())
	#song_data.play("SampleSong")
#
#func show_warning(key: String, button: int) -> void:
	#var tween: Tween = create_tween()
	#tween.tween_property(buttons[button], "scale", Vector2.ONE, NOTE_WARNING-LENIENCY)
#
#func open_window(key: String, button: int) -> void:
	#var valid_action = {
		#"key": key,
		#"button": button
	#}
	#open_windows.append(valid_action)
	#var tween: Tween = create_tween()
	#tween.tween_property(buttons[button], "modulate", Color("#ffffff", 0.2), LENIENCY)
	#print("open " + str(valid_action))
#
#func note(key: String, button: int) -> void:
	#var tween: Tween = create_tween()
	#tween.tween_property(buttons[button], "modulate", Color("#ffffff", 1), LENIENCY)
	#tween.tween_callback(close_earliest_window).set_delay(LENIENCY)
	#print(key + " " + str(button))
#
#func close_earliest_window():
	#buttons[open_windows[0].button].scale = Vector2.ZERO
	#open_windows.remove_at(0)
#
#func _input(event: InputEvent) -> void:
	#var key_clicked: String = ""
	#if Input.is_action_just_pressed("A"):
		#key_clicked = "A"
	#if Input.is_action_just_pressed("S"):
		#key_clicked = "S"
	#if Input.is_action_just_pressed("D"):
		#key_clicked = "D"
	#if Input.is_action_just_pressed("F"):
		#key_clicked = "F"
	#if key_clicked != "":
		#if open_windows.is_empty() or key_clicked != open_windows[0].key:
			#print("wrong note")
		#elif key_clicked == open_windows[0].key:
			#var button_num: int = open_windows[0].button
			#if get_local_mouse_position().distance_to(buttons[button_num].position) > 50:
				#print("mouse miss")
			#else:
				#print("hit!")


func _on_conductor_beat(position: Variant) -> void:
	pass # Replace with function body.
