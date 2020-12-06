extends Area2D


const SPEED = -80
var motion = Vector2()



func _ready():
	pass

func _physics_process(delta):
	
	motion.x = SPEED * delta
	translate(motion)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_EnemyBullet_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
	if body.is_in_group("Bullet"):
		queue_free()
		body.queue_free()
