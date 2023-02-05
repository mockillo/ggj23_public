extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func small_shake() -> void:
	# $ScreenShake.start(0.1, 15, 4, 0)
	$ScreenShake.start()


func big_shake() -> void:
	$ScreenShake.start(0.3, 50, 12, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
