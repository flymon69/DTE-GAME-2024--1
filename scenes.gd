extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY =0
@export var ACCELERATION: float = 15.0

enum state {IDLE, RUNNING, JUMPUP, JUMPDOWN, HURT}

var anim_state = state.IDLE

@onready var animator = $AnimatedSprite2D
@onready var animationplayer = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED,direction * ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION/2)

	move_and_slide()
