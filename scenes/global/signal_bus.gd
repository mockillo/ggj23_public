extends Node

signal step_started
signal step_missed
signal step_completed
signal sequence_ended
signal sequence_started

export var allow_input = false
var fails = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

func emit_step_started(step):
	emit_signal("step_started", step)

func emit_step_completed(step):
	print("--------------------STEP COMPLETED")
	emit_signal("step_completed", step)
	
func emit_step_missed(step):
	print("--------------------STEP MISSED")
	fails = fails + 1
	emit_signal("step_missed", step)

func emit_sequence_ended():
	print("--------------------SEQUENCE ENDED")
	emit_signal("sequence_ended")
	
func emit_sequence_started():
	print("--------------------SEQUENCE started")
	emit_signal("sequence_started")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
