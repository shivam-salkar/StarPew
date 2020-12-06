extends Node2D



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		get_tree().change_scene("res://Assets/UI/Scenes/DedScreen.tscn")
		queue_free()
