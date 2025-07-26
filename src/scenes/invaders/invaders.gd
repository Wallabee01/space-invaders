extends Node2D

const MOVE_STEP: float = 4.0
const START_WAIT_TIME: float = 4.0

var move_count: int = 0
var moving_left: bool = true
var moving_down: bool = false
var first_move_step: bool = true

@onready var move_timer = %MoveTimer
@onready var move_stream_player = %MoveStreamPlayer


func _ready():
	GameEvents.invader_destroyed.connect(_on_invader_destroyed)
	GameEvents.game_over.connect(_on_game_over)


func set_move_timer_wait_time(wait_time: float):
	move_timer.wait_time = wait_time
	move_timer.start()


func _on_move_timer_timeout():
	move_stream_player.pitch_scale = randf_range(0.9, 1.1)
	move_stream_player.play()
	
	if first_move_step:
		_move_left()
		if move_count == 4:
			first_move_step = false
			moving_left = false
			move_count = 0
			moving_down = true
			return
		return
	
	if moving_down:
		_move_down()
		moving_down = false
		return
	
	if moving_left:
		_move_left()
		if move_count == 8:
			move_count = 0
			moving_left = false
			moving_down = true
			return
	else:
		_move_right()
		if move_count == 8:
			move_count = 0
			moving_left = true
			moving_down = true
			return


func _move_left():
	move_count += 1
	global_position = Vector2(global_position.x - MOVE_STEP, global_position.y)


func _move_right():
	move_count += 1
	global_position = Vector2(global_position.x + MOVE_STEP, global_position.y)


func _move_down():
	global_position = Vector2(global_position.x, global_position.y + MOVE_STEP)


func _on_invader_destroyed():
	move_timer.wait_time -= 0.02
	move_timer.wait_time = clamp(move_timer.wait_time, 1.0, 4.0)
	GameEvents.move_timer_wait_time = move_timer.wait_time


func _on_game_over():
	move_timer.wait_time = START_WAIT_TIME
	GameEvents.move_timer_wait_time = move_timer.wait_time
