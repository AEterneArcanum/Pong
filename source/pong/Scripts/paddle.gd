extends Node2D

signal on_paddle_hit

@export var action_counter_clockwise:String = "inp_player_one_left"
@export var action_clockwise:String = "inp_player_one_right"

@export var Ball:Node2D

@export var arm_radius:float = 300
@export var arm_speed:float = 3

func _ready() -> void:
	$PaddleA.move_local_x(arm_radius)
	$PaddleB.move_local_x(-arm_radius)

func _process(delta: float) -> void:
	var control_axis = Input.get_axis(action_counter_clockwise, action_clockwise)
	rotate(control_axis * arm_speed * delta)

func _on_paddle_a_area_entered(area: Area2D) -> void:
	if area.get_parent() == Ball:
		on_paddle_hit.emit()

func _on_paddle_b_area_entered(area: Area2D) -> void:
	if area.get_parent() == Ball:
		on_paddle_hit.emit()
