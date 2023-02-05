extends Node

const TRANSITION = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var _amplitude = 0
var _priority = 0

onready var camera = get_parent()


func start(duration = 0.2, frequency = 15, amplitude = 16, priority = 0):
	if priority >= self._priority:
		self._priority = priority
		self._amplitude = amplitude

		$Duration.wait_time = duration
		$Frequency.wait_time = frequency
		$Duration.start()
		$Frequency.start()

		print(
			"Duration: ",
			duration,
			", freq: ",
			frequency,
			", amplitude: ",
			amplitude,
			", priority: ",
			priority
		)
		_new_shake()


func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-_amplitude, _amplitude)
	rand.y = rand_range(-_amplitude, _amplitude)

	$ShakeTween.interpolate_property(
		camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANSITION, EASE
	)
	$ShakeTween.start()


func _reset():
	$ShakeTween.interpolate_property(
		camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANSITION, EASE
	)
	$ShakeTween.start()

	_priority = 0


# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Frequency_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	$Frequency.stop()
