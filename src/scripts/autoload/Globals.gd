extends Node

signal score_changed

var score = 0 setget set_score

func set_score(val):
	score = val
	emit_signal("score_changed")
