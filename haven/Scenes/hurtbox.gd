extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox: MyHitBox) -> void:
	if hitbox != null:
		owner.queue_free()	
	
