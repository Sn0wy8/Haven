extends CharacterBody2D
@onready var AnimPlayer: AnimationPlayer = $AnimationPlayer
@onready var GraceTimer: Timer = $GraceTimer

const IS_PLAYER = true
var speed: float = 1200
@onready var direction = Vector2(1,0).rotated(rotation)

func _ready() -> void:
	get_node("MyHitBox/CollisionShape2D").disabled = true
	GraceTimer.start
	print("rizz")

func _on_grace_timer_timeout() -> void:
	get_node("MyHitBox/CollisionShape2D").disabled = false
	print("rizz")

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction*speed*delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
	velocity = Vector2(1,0).rotated(rotation) * speed * delta

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "remove":
		queue_free()


func _on_distance_timer_timeout() -> void:
	AnimPlayer.play("remove")
