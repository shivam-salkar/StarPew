extends Area2D

const SPEED = 100
var motion = Vector2()
var player = preload("res://Assets/Actors/Player/Player.tscn")

func _ready():
	connect("body_entered",self,"body_entered")

func _physics_process(delta):
	
	motion.x = SPEED * delta
	translate(motion)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func body_entered(body):
	if body.is_in_group("Enemy"):
		body.hp -= 1
		
