class_name  Note
extends Node2D

var current_note = null
var size: int = 10
var input = ""

signal clicked(note: Note, status: String, early: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init_note(pos: Vector2, inp: String) -> void:
	position = pos
	size = 60
	input = inp
	modulate = Color("#ffffff00")
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "size", 20, 1)
	tween.parallel().tween_property(self, "modulate", Color("#FFFFFFFF"), 1)
	tween.tween_property(self, "size", 0, 0.5)

func _process(delta) -> void:
	if size <= 2:
		clicked.emit(self, "Fail", false)
	queue_redraw()

func _unhandled_input(_event):
	var status: String = ""
	var early: bool = false
	if Input.is_action_just_pressed(input):
		if size >= 33: 
			status = "Miss"
			early = true
		elif size >= 28:
			status = "Okay"
			early = true
		elif size >= 24:
			status = "Good"
			early = true
		elif size >= 22:
			status = "Perfect"
			early = true
		elif size >= 19:
			status = "Perfect!!"
		elif size >= 17:
			status = "Perfect"
		elif size >= 12:
			status = "Good"
		elif size >= 7:
			status = "Okay"
		elif size >= 2:
			status = "Miss"
		else: 
			status = "Fail"
		clicked.emit(self, status, early)

func _draw() -> void:
	draw_circle(Vector2.ZERO, size, Color("f27633ff"))
