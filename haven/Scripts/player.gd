extends CharacterBody2D

var health = 3
var hearts_list : Array [TextureRect]
@onready
var animations = $animations
@onready
var gun = $GunPivot/Gun
@onready
var gun_pivot: Marker2D = $GunPivot
@export
var gun_hold_distance: float

const MAX_SPEED = 1000
const MAX_Y_SPEED = 900
const SPEED = 900
const CONST_FORWARD = 10
const VERT_VELOCITY = -3000
const FORWARD_DIR = Vector2.RIGHT
const GRAVITY = 900
const DRAG = 300

func _ready() -> void:
	var hearts_parents = $CanvasLayer/HBoxContainer
#	for child in hearts_parents.get_children():
#		hearts_list.append(child)
	print(hearts_list)

func Drag_Function() -> void:
		velocity.y = lerp(velocity.x, float(0), 0.01)

func _physics_process(delta: float) -> void:
	velocity.x = CONST_FORWARD
	move_and_slide()
	print(velocity.y)
	if not is_on_floor() and velocity.y <= MAX_Y_SPEED:
			velocity.y += GRAVITY * delta 
			velocity.y -= velocity.y * delta

	if Input.is_action_pressed("UP"):
		velocity.y += VERT_VELOCITY * delta
		velocity.y -= GRAVITY * delta
		
	if Input.is_action_pressed("DOWN"):
		velocity.y -= VERT_VELOCITY * delta
		velocity.y -= GRAVITY * delta 
		
		
	var direction := Input.get_axis("LEFT", "RIGHT")
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
	if health == 0:
		print("DEAD")
