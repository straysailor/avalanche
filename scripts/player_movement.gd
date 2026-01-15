extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var hitbox = $CollisionShape2D
@onready var slidebox = $SlideCollider

@export var SPEED = 600.0
@export var JUMP_VELOCITY = -450.0
@export var FRICTION = 100

var sliding = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if !sliding:
			anim_sprite.play("run")
			velocity.x = direction * SPEED
		if direction < 0:
			anim_sprite.flip_h = true
		else:
			anim_sprite.flip_h = false
			
	else:
		if !sliding:
			anim_sprite.play("idle")
			velocity.x = move_toward(velocity.x, 0, FRICTION)
	if Input.is_action_pressed("slide"):
		if !sliding:
			velocity.x = 1500 * direction
			sliding = true
			FRICTION = 10
			hitbox.disabled = true
			slidebox.disabled = false

	if sliding:
		anim_sprite.play("slide")
		FRICTION += 1
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		
	if Input.is_action_just_released("slide"):
		sliding = false
		FRICTION = 100
		hitbox.disabled = false
		slidebox.disabled = true
		
		
	if !is_on_floor():
		anim_sprite.play("jump")
	move_and_slide()
