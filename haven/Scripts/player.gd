extends CharacterBody2D
class_name main_player

var health = 5
var player_safe = false
var time_safe : float = 0.5 
var hearts_list : Array [TextureRect]
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun = $GunPivot/Gun
@onready var gun_pivot: Marker2D = $GunPivot
@export var gun_hold_distance: float
@onready var particle: CPUParticles2D = $CPUParticles2D

const MAX_SPEED = 1000
const MAX_Y_SPEED = 900
const SPEED = 600
const CONST_FORWARD = 400
const VERT_VELOCITY = -2500
const FORWARD_DIR = Vector2.RIGHT
const GRAVITY = 1000

@export var player_velocity = Vector2(velocity.x,velocity.y)

func _ready() -> void:
	var hearts_parents = $health_bar/HBoxContainer
	for child in hearts_parents.get_children():
		hearts_list.append(child)
	print(hearts_list)
	$health_timer.wait_time = time_safe

func _physics_process(delta: float) -> void:
	velocity.x = CONST_FORWARD
	move_and_slide()
	print(velocity.y)
	if not is_on_floor():
		particle.emitting = true	
		if velocity.y <= MAX_Y_SPEED:
			velocity.y += GRAVITY * delta 
	else:
		particle.emitting = false	
		
	if Input.is_action_pressed("UP"):
		velocity.y += VERT_VELOCITY * delta
		velocity.y -= GRAVITY * delta
		animation.play("rising")
	elif Input.is_action_pressed("DOWN"):
		velocity.y -= VERT_VELOCITY * delta
		velocity.y -= GRAVITY * delta 
		animation.play("falling")
	else:
		animation.play("default")
		
		
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
	print(velocity.y)

func take_damage(delta: float) -> void:
	if player_safe == false:
		if health > 0:
			health -= 1
			player_safe = true
			update_heart_display()
			$health_timer.start()
			if  health == 0:
				get_tree().change_scene_to_file("res://Scenes/DEATH.tscn")

		
func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health


func _on_health_timer_timeout() -> void:
	player_safe = false
