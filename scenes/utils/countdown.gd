extends Node2D

signal countdown_done

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_countdown():
	$AnimationPlayer.play("Countdown")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("countdown_done")
