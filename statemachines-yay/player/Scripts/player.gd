class_name Player
extends CharacterBody2D

@onready
var state_machine = $state_machine

func _ready() -> void:
	state_machine.init(self)
	add_to_group("Player")
	
	if GlobalScript.checkpoint_pos != Vector2(-999, -999):
		global_position = GlobalScript.checkpoint_pos
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
