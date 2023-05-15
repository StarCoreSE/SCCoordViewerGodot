extends Node2D

var viewport = null
var camera = "nullRTSCA"


func _input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.scancode == KEY_R && key_event.pressed:
			change_camera()

func change_camera():
	viewport.remove_child(viewport.camera)
	viewport.camera = camera
