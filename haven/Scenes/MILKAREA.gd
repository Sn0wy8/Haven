extends Area2D
class_name milk_ending_start
@export var ending_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_area_entered(milk:Area2D) -> void:
	if milk != null:
		get_tree().change_scene_to_file("res://Scenes/win.tscn")
	print("hihihi")
