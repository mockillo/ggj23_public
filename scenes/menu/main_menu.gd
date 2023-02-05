extends Node2D

var bpm = 100.0

func _ready():
	randomize()
	
	$VBoxContainer/StartButton.grab_focus()
	$ChopTimer0.wait_time = 60 / bpm
	$ChopTimer1.wait_time = (60 / bpm) * 2
	yield(get_tree().create_timer(1.0), "timeout")
	$MenuMusic.play()
	$ViewportContainer/Viewport/ViewportContent/Character0.chop()
	$ViewportContainer/Viewport/ViewportContent/Character1.chop()
	$ChopTimer0.start()
	$ChopTimer1.start()
	SignalBus.fails = 0

func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/game/main.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
	
func _input(event): 
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_MenuMusic_finished():
	# Set up player and timer again
	$ChopTimer0.stop()
	$ChopTimer1.stop()
	yield(get_tree().create_timer(2.0), "timeout")
	
	$MenuMusic.play()
	$ChopTimer0.start()
	$ChopTimer1.start()


func _on_ChopTimer0_timeout():
	$ViewportContainer/Viewport/ViewportContent/Character0.chop()
	


func _on_ChopTimer1_timeout():
	$ViewportContainer/Viewport/ViewportContent/Character1.chop()
