extends Control

var cursor = load("res://Assets/cursor/cursor.png")

func _process(delta):
	
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	Input.set_custom_mouse_cursor(cursor)
