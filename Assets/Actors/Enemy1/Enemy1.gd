extends KinematicBody2D

export var moveSpeed = 2000

const BULLET = preload("res://Assets/Actors/Enemy1/EnemyBullet.tscn")
const PLAYER = preload("res://Assets/Actors/Player/Player.tscn")
var explosion = preload("res://Assets/Particles/ExplosionParticle.tscn")


var is_dead = false
var can_shoot = true

var hp = 3

func _physics_process(delta):
	
	if hp <= 0:
		queue_free()
	
	var motion = Vector2()
	
	if !is_dead:
		
		motion.x -= 1
		
		motion = motion.normalized()
		motion = move_and_slide(motion * moveSpeed * delta, Vector2.UP)
		
		if can_shoot == true:
			fire()
			$ShootTimer.start()
			can_shoot = false

func fire():
	var bullet = BULLET.instance()
	bullet.position = $Position2D.global_position
	get_parent().get_parent().get_node("Bullets").add_child(bullet)

func explode():
	var Explosion = explosion.instance()
	Explosion.position = global_position
	get_parent().get_parent().get_node("Particles").add_child(Explosion)


func _on_Area2D_body_entered(body):
	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("Bullet"):
		queue_free()
		get_parent().get_node("Player").score += 10
		area.queue_free()
		explode()
	if area.is_in_group("Player"):
		queue_free()
		explode()
		area.get_parent().health -= 10


func _on_ShootTimer_timeout():
	can_shoot = true
