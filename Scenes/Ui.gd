extends Control

@onready var score_label: Label = $ScoreLabel

const COLORS: Dictionary[String, Color] = {
	"Perfect!!": Color("#e8a827ff"),
	"Early Perfect": Color("#b56031ff"),
	"Late Perfect": Color("#b56031ff"),
	"Early Good": Color("#1b8f78ff"),
	"Late Good": Color("#1b8f78ff"),
	"Early Okay": Color("#3d4a47ff"),
	"Late Okay": Color("#3d4a47ff"),
	"Early Miss": Color("#a12525ff"),
	"Late Miss": Color("#a12525ff"),
	"Fail": Color("#1c0000ff"),
}

func update_score(val: int) -> void:
	score_label.text = str(val)

func show_feedback(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.position = Vector2(randf_range(50,500), randf_range(120,204))
	label.label_settings = LabelSettings.new()
	label.label_settings.font_color = COLORS[text]
	label.label_settings.font_size = 20
	label.label_settings.outline_color = Color.WHITE
	label.label_settings.outline_size = 2
	var tween: Tween = create_tween()
	tween.tween_property(label, "scale", Vector2.ONE, 0.5)
	tween.parallel().tween_property(label, "modulate", Color("#FFFFFFFF"), 0.25)
	tween.tween_property(label, "modulate", Color("#FFFFFF00"), 0.25).set_delay(0.5)
	tween.tween_callback(label.queue_free)
	add_child(label)
	
