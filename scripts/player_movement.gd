extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D

@export var SPEED = 600.0
@export var JUMP_VELOCITY = -450.0
@export var FRICTION = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		anim_sprite.play("run")
		if direction < 0:
			anim_sprite.flip_h = true
		else:
			anim_sprite.flip_h = false
		velocity.x = direction * SPEED
	else:
		anim_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		
	if !is_on_floor():
		anim_sprite.play("jump")
	move_and_slide()
