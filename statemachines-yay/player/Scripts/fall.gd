# jump.gd
extends State

@export
var jump_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var dash_state: State

@export
var fall_force: float = 700.0

func enter() -> void:
	parent.velocity.y = fall_force  * 0.1

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y < 0:
		return jump_state
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if Input.is_action_just_pressed('dash'):
		return dash_state
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	return null
