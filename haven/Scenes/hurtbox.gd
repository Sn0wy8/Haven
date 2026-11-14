extends Area2D

const bullet = preload("res://Scenes/bullet.tscn")

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: BreakCollide) -> void:
	var new_bullet = bullet.instantiate()
	if hitbox != null:
		new_bullet.expand_circle(100)
		await get_tree().create_timer(0.03).timeout
		new_bullet.shrink_circle(100)
		owner.queue_free()
		print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm")
	
