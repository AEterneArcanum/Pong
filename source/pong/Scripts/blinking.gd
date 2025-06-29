extends Label

@export var animation_time:float = 2
@export var phasing_time:float = 1.5

var elapsed_time:float = 0

func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time > animation_time: elapsed_time -= animation_time
	visible = elapsed_time < phasing_time
