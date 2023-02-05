extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	run_game()
	yield(SignalBus, "sequence_ended")
	yield(get_tree().create_timer(2.0), "timeout")
	if SignalBus.fails >= 4:
		$"../Vignette".complete_darkness()
		yield(get_tree().create_timer(1.0), "timeout")
		$"../EndOfWorldLabel".visible = true
		yield(get_tree().create_timer(10.0), "timeout")
		get_tree().change_scene("res://scenes/menu/main_menu.tscn")
	else:
		get_tree().change_scene("res://scenes/game/main.tscn")

func run_game():
	$"../ListenLabel".visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	$"../ListenLabel".visible = false
	var seq = $"../SequenceGenerator".generate_sequence()
	var sequenceRunner = $"../SequenceRunner"
	sequenceRunner.set_sequence(seq)
	sequenceRunner.demo_sequence()
	yield(sequenceRunner, "demo_ended")
	sequenceRunner.start()
	yield(sequenceRunner, "sequence_ended")

func validate_life():
	pass
