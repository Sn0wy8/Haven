extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		killplayer(body)

func killplayer(Player: Node2D):
	Player.global_position = GlobalScript.checkpoint_pos
