extends Node2D

var hit = preload("res://scenes/utils/Hit.tscn")
var miss = preload("res://scenes/utils/Miss.tscn")

func _ready():
	SignalBus.connect("step_missed", self, "display_miss")
	SignalBus.connect("step_completed", self, "display_hit")
	
func display_hit(_step):
	var new_hit = hit.instance()
	add_child(new_hit)
	
func display_miss(_step):
	var new_miss = miss.instance()
	add_child(new_miss)
