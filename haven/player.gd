extends CharacterBody2D

var health = 3
@onready
var animations = $animations
@onready
var gun = $GunPivot/Gun
@onready
var gun_pivot: Marker2D = $GunPivot
@export
var gun_hold_distance: float

const SPEED = 300.0
const RIGHT_SPEED = 10
const JUMP_VELOCITY = -15.0
const FORWARD_DIR = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	velocity.x = RIGHT_SPEED
	move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.5
 
	# Handle jump.
	if Input.is_action_pressed("ui_accept"):
		velocity.y += JUMP_VELOCITY
		
	# Downward Dash
	if Input.is_action_pressed("ui_down"):
		velocity.y -= -5
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	var mouse_direction := gun_pivot.global_position.direction_to(get_global_mouse_position())
	gun.position = mouse_direction * gun_hold_distance
	gun.scale.y = 1 if mouse_direction.x > 0 else -1
	gun.show_behind_parent = mouse_direction.y < 0
	gun.look_at(get_global_mouse_position())
	
func take_damage(delta: float) -> void:
	health -= 1
	if health 
