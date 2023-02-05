extends Node2D

export var flipped: bool = false
export(int, 0, 3) var id: int = 0

signal character_activated(id)

var sounds = [
	"res://audio/axe-short-chop.wav",
	"res://audio/axe-sharp-chop.wav",
	"res://audio/axe-medium-chop.wav",
	"res://audio/axe-heavy-chop.wav"
]

var keysprites = [
	"res://sprites/lumberjacks/key_1.png",
	"res://sprites/lumberjacks/key_2.png",
	"res://sprites/lumberjacks/key_3.png",
	"res://sprites/lumberjacks/key_4.png"
]

func _ready():
	SignalBus.connect("sequence_started", self, "_show_keys")
	SignalBus.connect("sequence_ended", self, "_hide_keys")
	
	var chop_sound = load(sounds[id])
	$AudioStreamPlayer.stream = chop_sound
	
	var key_graphic = load(keysprites[id])
	$KeySprite.texture = key_graphic

	if flipped:
		$AnimatedSprite.flip_h = true
		$Particles2D.position.x = -$Particles2D.position.x
		$Particles2D.scale.x = -1 * $Particles2D.scale.x

func player_chop():
	if not SignalBus.allow_input:
		return
		
	emit_signal("character_activated", id)
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop(true)
	$AnimationPlayer.play("Chop")
	$AudioStreamPlayer.play()

func chop():
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop(true)
	$AnimationPlayer.play("Chop")
	$AudioStreamPlayer.play()

func _input(event):
	if event.is_action_pressed("input_axe%s" % id):
		player_chop()

func _on_Button_button_down():
	player_chop()
	
func _show_keys():
	$KeySprite.visible = true;
	
func _hide_keys():
	$KeySprite.visible = false;
