'''The Player Script '''

extends KinematicBody2D

export var moveSpeed = 100

onready var shootTimer = $Timers/ShootTimer
onready var bulletPos = $Positions/BulletPos
onready var camera = get_parent().get_parent().get_node("Camera2D")
var crosshair = load("res://Assets/cursor/crosshair.png")

var can_shoot = true
var is_ded = false
var should_explode = false

var score = 0

var health = 100


const BULLET = preload("res://Assets/Actors/Player/Bullet/Bullet.tscn")
const SHOOTPARTICLE = preload("res://Assets/Particles/ShootParticles.tscn")
const EXPLOSION = preload("res://Assets/Particles/PlayerExplosionParticle.tscn")

func _ready():
	Input.set_custom_mouse_cursor(crosshair)

func _physics_process(delta):
	
	if is_ded == true:
		$Sprite.visible = false
		$CollisionShape2D.disabled = true
		
		get_parent().get_parent().get_node("UI/Healthbar").queue_free()
		can_shoot = false
		should_explode = true
		queue_free()
		explode()
	
	if should_explode == true:
		explode()
	
	if health <= 0:
		is_ded = true
		
	
	if is_ded == false:
		var motion = Vector2()
		
		if Input.is_action_pressed("up"):
			motion.y -= 1
		if Input.is_action_pressed("down"):
			motion.y += 1
		if Input.is_action_pressed("right"):
			motion.x += 1
		if Input.is_action_pressed("left"):
			motion.x -= 1
		
		
		if Input.is_action_just_pressed("lmb") and can_shoot == true:
			fire()
			can_shoot = false
			shootTimer.start()
			shootParticleinstance()
		
		motion = motion.normalized()
		motion = move_and_slide(motion * moveSpeed * delta)
	
	#Score
	get_parent().get_parent().get_node("UI/score/ScoreLabel").text = str(score)
	

func fire():
	var bullet_instance = BULLET.instance()
	bullet_instance.position = bulletPos.global_position
	get_parent().get_parent().get_node("Bullets").add_child(bullet_instance)


func _on_ShootTimer_timeout():
	can_shoot = true


func _on_HitArea_body_entered(body):
	if body.is_in_group("Enemy"):
		health -= 10
		$Hiteffect.play()


func shootParticleinstance():
	var shootparticle = SHOOTPARTICLE.instance()
	shootparticle.position = bulletPos.global_position
	get_parent().get_parent().get_node("Particles").add_child(shootparticle)

func explode():
	var explosion = EXPLOSION.instance()
	explosion.position = global_position
	get_parent().get_parent().get_node("Particles").add_child(explosion)
	
	should_explode = false


func _on_HitArea_area_entered(area):
		if area.is_in_group("Enemy Bullet"):
			health -= 10
			$Hiteffect.play()
