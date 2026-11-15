extends Area2D

const bullet = preload("res://Scenes/bullet.tscn")
var break_size = 30

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: BreakCollide) -> void:
	var new_bullet = bullet.instantiate()
	if hitbox != null:
		new_bullet.expand_circle(break_size)
		await get_tree().create_timer(0.05 ).timeout
		new_bullet.shrink_circle(break_size)
		owner.queue_free()
		print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm")
	
