extends Control

@onready var score_label: Label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_score(val: int) -> void:
	score_label.text = str(val)
