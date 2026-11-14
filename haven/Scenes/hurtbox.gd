extends Area2D

@onready var collision_shape = $Colliding/BreakCollide/BreakShape

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	
func expand_circle(amount: float) -> void:
	var circle_shape = collision_shape.shape as CircleShape2D
	if circle_shape:
		circle_shape.radius += amount
		await get_tree().create_timer(0.5).timeout
		circle_shape.radius -= amount

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: BreakCollide) -> void:
	if hitbox != null:
		expand_circle(100)
		owner.queue_free()	
	
