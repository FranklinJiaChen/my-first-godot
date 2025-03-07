extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _ready():
	anim.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.y > 0:
		anim.play("fall")
	elif velocity.y < 0:
		anim.play("jump")
	elif direction:
		anim.play("run")
	else:
		anim.play("idle")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Game.playerHP <= 0:
		get_tree().change_scene_to_file("res://MainMenu.tscn")
		Game.high_score = max(Game.high_score, Game.score)
		Game.score = 0
		Game.playerHP = 10
		Utils.save_game()

	move_and_slide()
