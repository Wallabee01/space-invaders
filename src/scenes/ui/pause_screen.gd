extends CanvasLayer

var is_paused: bool = false


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if !is_paused:
			is_paused = true
			get_tree().paused = true
			visible = true
		else:
			is_paused = false
			get_tree().paused = false
			visible = false


func _on_quit_button_pressed():
	GameEvents.check_high_score()
	get_tree().quit()
