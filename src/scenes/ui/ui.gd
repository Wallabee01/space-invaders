extends CanvasLayer

@onready var score_label = %ScoreLabel
@onready var high_score_label = %HighScoreLabel
@onready var life_1_texture_rect = %Life1TextureRect
@onready var life_2_texture_rect = %Life2TextureRect
@onready var life_3_texture_rect = %Life3TextureRect
@onready var panel_container = %PanelContainer


func _ready():
	GameEvents.lives_changed.connect(_on_lives_changed)
	GameEvents.score_changed.connect(_on_score_changed)
	GameEvents.high_score_changed.connect(_on_high_score_changed)
	GameEvents.game_over.connect(_on_game_over)
	_on_score_changed(GameEvents.score)
	_on_high_score_changed(GameEvents.high_score)
	get_tree().paused = true


func _unhandled_input(event):
	if event.is_action_pressed("start"):
		panel_container.visible = false
		get_tree().paused = false
		get_tree().root.set_input_as_handled()


func _on_lives_changed(lives: int):
	match lives:
		3:
			life_3_texture_rect.visible = true
			life_2_texture_rect.visible = true
		2:
			life_3_texture_rect.visible = false
		1:
			life_2_texture_rect.visible = false


func _on_score_changed(score: int):
	score_label.text = "Score: " + str(score)


func _on_high_score_changed(high_score: int):
	high_score_label.text = "High Score: " + str(high_score)

func _on_game_over():
	get_tree().paused = true
	panel_container.visible = true
