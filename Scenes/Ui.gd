extends Control

@onready var score_label: Label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_score(val: int) -> void:
	score_label.text = str(val)

func show_feedback(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.position = Vector2(randf_range(50,200), randf_range(120,204))
	var tween: Tween = create_tween()
	tween.tween_property(label, "scale", Vector2.ONE, 0.5)
	tween.parallel().tween_property(label, "modulate", Color("#FFFFFFFF"), 0.25)
	tween.tween_property(label, "modulate", Color("#FFFFFF00"), 0.25).set_delay(0.5)
	tween.tween_callback(label.queue_free)
	add_child(label)
