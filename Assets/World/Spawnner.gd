extends StaticBody2D

var enemy = preload("res://Assets/Actors/Enemy1/Enemy1.tscn")

func _ready():
	spawn()
	pass

func spawn():
	
	var Enemy = enemy.instance()
	Enemy.position = Vector2(190,rand_range(0,100))
	get_parent().get_parent().get_node("Entities").add_child(Enemy)
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
	


func _on_Timer_timeout():
	spawn()
	$Timer.start()
