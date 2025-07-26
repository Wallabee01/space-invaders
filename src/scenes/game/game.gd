extends Node

const INVADERS_SCENE: PackedScene = preload("res://src/scenes/invaders/invaders.tscn")
const SPACESHIP_SCENE: PackedScene = preload("res://src/scenes/invaders/spaceship.tscn")

var invaders_destroyed: int = 0

@onready var bunkers = %Bunkers
@onready var invaders_parent = %InvadersParent
@onready var spaceship_parent = %SpaceshipParent
@onready var lasers = %Lasers
@onready var spaceship_timer = %SpaceshipTimer
@onready var game_over_stream_player = %GameOverStreamPlayer
@onready var audio_stream_player = %AudioStreamPlayer
@onready var player = %Player


func _ready():
	GameEvents.game_over.connect(_on_game_over)
	GameEvents.invader_destroyed.connect(_on_invader_destroyed)
	spaceship_timer.wait_time = randf_range(60.0, 120.0)
	spaceship_timer.start()


func _on_game_over():
	game_over_stream_player.pitch_scale = randf_range(0.9, 1.1)
	game_over_stream_player.play()
	
	invaders_destroyed = 0
	
	for child in bunkers.get_children():
		child.call_deferred("reset")
	
	invaders_parent.get_child(0).queue_free()
	var invaders_instance = INVADERS_SCENE.instantiate()
	invaders_parent.call_deferred("add_child", invaders_instance)
	
	for child in lasers.get_children():
		child.call_deferred("queue_free")
	
	for child in spaceship_parent.get_children():
		child.call_deferred("queue_free")


func _on_laser_death_area_2d_body_entered(body):
	body.queue_free()


func _on_spaceship_timer_timeout():
	var spaceship_instance = SPACESHIP_SCENE.instantiate()
	spaceship_parent.add_child(spaceship_instance)
	GameEvents.is_spaceship = true
	
	spaceship_timer.wait_time = randf_range(60.0, 120.0)
	spaceship_timer.start()


func _on_invader_destroyed():
	invaders_destroyed += 1
	
	if invaders_destroyed == 60:
		audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
		audio_stream_player.play()
		GameEvents.update_score(1000)
		
		invaders_parent.get_child(0).queue_free()
		var invaders_instance = INVADERS_SCENE.instantiate()
		invaders_parent.call_deferred("add_child", invaders_instance)
		invaders_destroyed = 0
		invaders_instance.call_deferred("set_move_timer_wait_time", GameEvents.move_timer_wait_time)
		
		for child in lasers.get_children():
			child.call_deferred("queue_free")
		
		player.increase_shoot_speed()
