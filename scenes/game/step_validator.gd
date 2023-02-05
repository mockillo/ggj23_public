extends Node

class_name StepValidator

signal validator_done
var gracePeriodMs: int = 100
var active = false
var stepAttempted
var stepNo: int
var expectedInput: int

func _ready():
	$"../../ViewportContainer/Viewport/Character0".connect("character_activated", self, "_on_character_activated")
	$"../../ViewportContainer/Viewport/Character1".connect("character_activated", self, "_on_character_activated")
	$"../../ViewportContainer/Viewport/Character2".connect("character_activated", self, "_on_character_activated")
	$"../../ViewportContainer/Viewport/Character3".connect("character_activated", self, "_on_character_activated")

func check_step(input: int, whichStep: int, delayMs: int):
	stepAttempted = false
	stepNo = whichStep
	expectedInput = input
	print("Starting step timeout timer")
	yield(get_tree().create_timer((delayMs + gracePeriodMs) / 1000.0), "timeout")
	if (!stepAttempted):
		print("Miss ", stepNo)
		SignalBus.emit_step_missed(stepNo)
	print("Validator done for step ", stepNo)
	emit_signal("validator_done", stepNo)
	
func reset():
	stepNo = 0

func _on_character_activated(id: int):
	print("Checking if ", id, " is in ", expectedInput)
	if (stepAttempted):
		print("Step ", stepNo, " already attempted")
#		print("Miss ", stepNo)
#		SignalBus.emit_step_missed(stepNo)
		return
	if id == expectedInput:
		print("Hit ", stepNo)
		SignalBus.emit_step_completed(stepNo)
	else:
		print("Miss ", stepNo)
		SignalBus.emit_step_missed(stepNo)
	
	stepAttempted = true
