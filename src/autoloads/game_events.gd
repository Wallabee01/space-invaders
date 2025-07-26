extends Node

const SAVE_FILE_PATH = "user://game.save"

signal lives_changed(lives)
signal score_changed(score)
signal high_score_changed(high_score)
signal game_over()
signal invader_destroyed

var lives: int = 3
var score: int = 0
var high_score: int = 0
var is_spaceship:bool = false
var move_timer_wait_time: float = 4.0


func _ready():
	load_save_file()


func update_lives(num: int):
	lives += num
	lives_changed.emit(lives)
	
	if lives == 0:
		reset_game()


func update_score(num: int):
	score += num
	score_changed.emit(score)


func reset_game():
	game_over.emit()
	
	check_high_score()
	
	lives = 3
	score = 0
	
	lives_changed.emit(lives)
	score_changed.emit(score)


func check_high_score():
	if score > high_score:
		high_score = score
		high_score_changed.emit(high_score)
		save()

func load_save_file():
	if !FileAccess.file_exists(SAVE_FILE_PATH): return
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	high_score = file.get_var()


func save():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(high_score)
