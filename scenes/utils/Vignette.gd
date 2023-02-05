extends TextureRect

func _ready():
	SignalBus.connect("step_missed", self, "_darken")
	SignalBus.connect("step_completed", self, "_lighten")

func _darken(_step):
	material.set_shader_param("vignette_intensity", max(material.get_shader_param("vignette_intensity") + .25, 1))

func _lighten(_step):
	material.set_shader_param("vignette_intensity", max(material.get_shader_param("vignette_intensity") - .25, 0))

func complete_darkness():
	$AnimationPlayer.play("CompleteDarkness");
