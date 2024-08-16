extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 50
var is_dead = false
@onready var anim = get_node("AnimatedSprite2D")
func _ready():
	anim.play("idle")

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	player = get_node("../../Player/Player")
	if chase:
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
		velocity.x = direction.x * SPEED
	else:
			velocity.x = 0
	if not is_dead:
		if chase:
			anim.play("jump")
		else:
			anim.play("idle")
	move_and_slide()


func _on_vision_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_vision_body_exited(body):
	if body.name == "Player":
		chase = false

func death(hit):
	is_dead = true
	if hit:
		Game.playerHP -= 3
	else:
		Game.score += 1
	anim.play("death")
	chase = false
	await anim.animation_finished
	self.queue_free()
	

func _on_hit_box_body_entered(body):
	if body.name == "Player" and not is_dead:
		death(true)

func _on_hurt_box_body_entered(body):
	if body.name == "Player" and not is_dead:
		death(false)
