extends Area2D
class_name Invader

const LASER_SCENE: PackedScene = preload("res://src/scenes/laser/enemy_laser.tscn")
const STAND_ALONE_STREAM_PLAYER_SCENE: PackedScene = preload("res://src/scenes/components/standalone_stream_player.tscn")
const HIT_SFX: AudioStream = preload("res://assets/audio/sfx/hurt1.ogg")

@onready var shoot_timer = %ShootTimer


func _ready():
	shoot_timer.wait_time = randf_range(20.0, 45.0)
	shoot_timer.start()


func _on_body_entered(body):
	if body.is_in_group("laser"):
		body.queue_free()
		GameEvents.update_score(10)
		GameEvents.invader_destroyed.emit()
		var stand_alone_stream_player_instance = STAND_ALONE_STREAM_PLAYER_SCENE.instantiate()
		get_parent().get_parent().add_child(stand_alone_stream_player_instance)
		stand_alone_stream_player_instance.stream = HIT_SFX
		stand_alone_stream_player_instance.pitch_scale = randf_range(0.9, 1.1)
		stand_alone_stream_player_instance.play()
		queue_free()


func _on_shoot_timer_timeout():
	var laser_instance = LASER_SCENE.instantiate()
	get_parent().get_parent().get_parent().find_child("Lasers").add_child(laser_instance)
	laser_instance.global_position = Vector2(global_position.x, global_position.y + 4)
	
	shoot_timer.wait_time = randf_range(20.0, 45.0)
	shoot_timer.start()
