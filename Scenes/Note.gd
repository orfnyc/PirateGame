class_name  Note
extends Node2D

var status: String = "miss"
var current_note = null
var size: int = 10

@export var input = ""

signal increment_score(amount: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init_note(pos: Vector2) -> void:
	position = pos
	size = 120
	modulate = Color("#ffffff00")
	var tween: Tween = create_tween()
	tween.tween_property(self, "size", 40, 1)
	tween.parallel().tween_property(self, "modulate", Color("#FFFFFFFF"), 1)
	tween.tween_property(self, "size", 0, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if size <= 2:
		increment_score.emit(-1)
		print("total miss")
		queue_free()
	if size >= 35 and size <= 45:
		status = "perfect"
	elif size >= 30 and size <= 50:
		status = "good"
	elif size >= 25 and size <= 55:
		status = "okay"
	else:
		status = "miss"
	queue_redraw()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if (position.distance_to(get_global_mouse_position()) <= 40):
				if status == "perfect":
					increment_score.emit(3)
					print(status)
				elif status == "good":
					increment_score.emit(2)
					print(status)
				elif status == "okay":
					increment_score.emit(1)
					print(status)
				else:
					increment_score.emit(-1)
					print(status)
				queue_free()

func _draw() -> void:
	draw_circle(Vector2.ZERO, size, Color("FF1447"))
