extends Node

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

var possible_players = [0, 1, 2, 3]

var possible_inputs = [0, 1, 2, 3]

#var possible_inputs = [
#	[0],
#	[1],
#	[2],
#	[3],
##	[0, 1],
##	[0, 2],
##	[0, 3],
##	[1, 2],
##	[1, 3],
##	[2, 3],
##	[0, 1, 2],
##	[0, 1, 3],
##	[0, 2, 3],
##	[1, 2, 3],
#]

#var bpm = 100.0
# delay = (60 * 1000 / bpm)
var possible_delays = [600, 1200]

#var possible_delays = [
##	250,
#	500,
#	750,
#	1000,
#]

func generate_sequence(length: int = 4) -> Array:
	rng.randomize()
	var inputs = get_step_inputs(length)
	var delays = get_next_delay(length)
	
	assert(inputs.size() == delays.size())
	
#	var sequence = {}
#	sequence["inputs"] = inputs
#	sequence["delays"] = delays
#
#	return sequence
	return [inputs, delays]


func get_next_delay(length = 4) -> Array:
	var delays = []
	for _i in length:
		var delay = possible_delays[randi() % possible_delays.size()]
		print("Adding delay {delay} to delays[{idx}]".format({"delay": delay, "idx": _i}))
		delays.append(delay)

	return delays


# Get the next input index (character) that will chop
func get_next_input() -> Array:
	return possible_inputs[randi() % possible_inputs.size()]


# How many characters will chop on this step?
func get_next_num_inputs(minimum = 1, maximum = 2) -> int:
	return rng.randi_range(minimum, maximum)
#	return possible_players[randi() % possible_players.size()]


func get_step_inputs(length = 4) -> Array:
	var inputs = []
	# Generate input(s) for each step
	for step in length:
		print("Generating keys for step ", step)
		
		var inputKey = get_next_input()
		print("Generated input key ", inputKey, " for step ", step)
		inputs.append(inputKey)

	print("Inputs ", inputs)
	return inputs

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
