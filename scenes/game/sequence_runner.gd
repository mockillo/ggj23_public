extends Node2D
signal demo_ended
signal sequence_started
signal sequence_ended

var inputs: Array = []
var delays: Array = []
var currentStep: int
var stepStartTime: int

var gameplayMusic = [
	"res://audio/dim_bass_loop_fatres.wav",
	"res://audio/dim_bass_loop_furrylog.wav",
	"res://audio/dim_bass_loop_spikebass.wav",
	"res://audio/dim_bass_loop_thump.wav",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Metronome".connect("metronome_completed", self, "on_metronome_completed")
	var music = load(gameplayMusic[randi() % gameplayMusic.size()])
	$"../AudioPlayer".stream = music

func set_sequence(seq: Array):
	self.inputs = seq[0]
	self.delays = seq[1]


func demo_sequence():
	$"../AudioPlayer".play()
	yield(get_tree().create_timer(0.6), "timeout")
	for i in len(inputs):
		var inputKey = inputs[i]
		var delayMs = delays[i]
		get_node("../ViewportContainer/Viewport/Character%s" % inputKey).chop()
		
		# Wait for specified delay
		yield(get_tree().create_timer(delayMs / 1000.0), "timeout")
	
	$"../TweenAudioFadeOut".interpolate_property($"../AudioPlayer", "volume_db", 0, -80.0, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$"../TweenAudioFadeOut".start()
	yield($"../TweenAudioFadeOut", "tween_completed")
	$"../AudioPlayer".stop()
	$"../AudioPlayer".volume_db = 0
	emit_signal("demo_ended")


func start():
	# Start metronome
	$"../Metronome".start_countdown()
	$"../Countdown".start_countdown()


func on_metronome_completed():
	print("Enabling input")
	SignalBus.allow_input = true
	run_sequence()
	yield(self, "sequence_ended")


func run_sequence():
	currentStep = 0
	print("Starting sequence")
	emit_signal("sequence_started")
	SignalBus.emit_sequence_started()
	$"../AudioPlayer".play()
	yield(get_tree().create_timer(0.6), "timeout")
	while currentStep < len(inputs):
		print("Step ", currentStep, " started")
		var input = inputs[currentStep]
		var delay = delays[currentStep]
		print("Running StepValidator on step ", currentStep)
		$StepValidator.check_step(input, currentStep, delay)
		yield($StepValidator, "validator_done")
		currentStep += 1
		
	SignalBus.allow_input = false
	print("Sequence run done")
	$"../AudioPlayer".stop()
	$StepValidator.reset()
	emit_signal("sequence_ended")
	SignalBus.emit_sequence_ended()
