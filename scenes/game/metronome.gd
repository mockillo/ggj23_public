extends Node2D

signal metronome_completed

var tick_count = 4
var current_tick = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$MetronomeTimer.connect("timeout", self, "on_metronome_timeout")
	pass


func start_countdown(ticks: int = 4):
	tick_count = ticks
	$MetronomeTimer.start()


func on_metronome_timeout():
	if current_tick < tick_count:
		$MetronomePlayer.play()
		$MetronomeTimer.start()
		current_tick += 1
	else:
		$MetronomePlayer.stop()
		emit_signal("metronome_completed")
