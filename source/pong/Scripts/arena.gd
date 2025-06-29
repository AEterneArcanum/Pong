extends Node2D

enum ArenaState {
	Initial,
	Playing
}

@export var initial_speed = 100

var player_score:int = 0
var high_score:int = 0
var arena_state:ArenaState = ArenaState.Initial

@onready var game_ball:Node = $Ball

func reset_ball() -> void:
	game_ball.reset()
func reset_score() -> void:
	if player_score > high_score: high_score = player_score
	player_score = 0
	update_score()
func update_score() -> void:
	$UI/ScoreCard.text = "𐑕𐑒𐑹 {0}".format([player_score])
func launch_ball() -> void:
	game_ball.launch(initial_speed, Vector2(randf(), randf()).normalized())

func hide_ui() -> void:
	$UI/ScoreCard.visible = true
	$UI/PressStartView.visible = false
	$UI/HighScoreCard.visible = false
	$UI/EndScoreCard.visible = false
func show_ui() -> void:
	$UI/ScoreCard.visible = false
	$UI/PressStartView.visible = true
	$UI/EndScoreCard.visible = true
	$UI/EndScoreCard.text = "𐑘𐑹 𐑕𐑒𐑹 : {0}".format([player_score])
	$UI/HighScoreCard.visible = player_score < high_score
	$UI/HighScoreCard.text = "𐑣𐑲 𐑕𐑒𐑹 : {0}".format([high_score])

func _process(_delta: float) -> void:
	match arena_state:
		ArenaState.Initial:
			if Input.get_action_strength("inp_start"):
				arena_state = ArenaState.Playing
				reset_score()
				launch_ball()
				hide_ui()
		ArenaState.Playing:
			# Adding entry to a pause state would occur here.
			pass

func _draw() -> void:
	draw_circle(Vector2.ZERO, 320, Color(0, 1, 1), false, 1)

func _on_paddle_on_paddle_hit() -> void:
	pass

func _on_ball_on_ball_hit() -> void:
	player_score += 1
	update_score()

func _on_bounds_area_exited(area: Area2D) -> void:
	if area.get_parent() == game_ball:
		if player_score > high_score: high_score = player_score
		reset_ball()
		show_ui()
		arena_state = ArenaState.Initial
