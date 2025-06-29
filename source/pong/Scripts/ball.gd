extends Node2D

signal on_ball_hit

@export var Paddle:Node2D
@export var Step:float = 5

var velocity:Vector2 = Vector2.ZERO
var speed:float = 0

func _process(delta: float) -> void:
	position += velocity * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() == Paddle:
		speed += Step
		on_ball_hit.emit()
		bounce(area.global_position)

func launch(launch_speed:float, launch_direction:Vector2) -> void:
	speed = launch_speed
	velocity = launch_direction.normalized() * speed

func reset() -> void:
	speed = 0
	velocity = Vector2.ZERO
	position = Vector2.ZERO

func accelerate(new_speed:float) -> void:
	speed = new_speed
	velocity = velocity.normalized() * speed

func bounce(surface_normal:Vector2) -> void:
	velocity = velocity.normalized().reflect(surface_normal.normalized()) * -1
	velocity *= speed
