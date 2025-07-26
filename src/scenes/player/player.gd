extends CharacterBody2D

const LASER_SCENE = preload("res://src/scenes/laser/laser.tscn")
const START_POSITION = Vector2(30.0, 174.0)
const START_SHOOT_SPEED: float = 1.0

@onready var velocity_component = %VelocityComponent
@onready var shoot_timer = %ShootTimer
@onready var hit_stream_player = %HitStreamPlayer
@onready var shoot_stream_player = %ShootStreamPlayer


func _ready():
	GameEvents.game_over.connect(_on_game_over)


func increase_shoot_speed():
	shoot_timer.wait_time -= 0.05
	shoot_timer.wait_time = clamp(shoot_timer.wait_time, 0.25, 1.0)


func _process(_delta):
	var movement_vector = _get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.move(self, direction)
	
	if Input.is_action_pressed("shoot") && shoot_timer.is_stopped():
		_shoot()


func _get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	return Vector2(x_movement, 0)


func _shoot():
	shoot_timer.start()
	
	var laser_instance = LASER_SCENE.instantiate()
	get_parent().find_child("Lasers").add_child(laser_instance)
	laser_instance.global_position = Vector2(global_position.x, global_position.y - 8)
	
	shoot_stream_player.pitch_scale = randf_range(0.9, 1.1)
	shoot_stream_player.play()


func _on_death_area_2d_body_entered(body):
	if body.is_in_group("enemy_laser"):
		global_position = START_POSITION
		GameEvents.update_lives(-1)
		hit_stream_player.pitch_scale = randf_range(0.9, 1.1)
		hit_stream_player.play()


func _on_game_over():
	shoot_timer.wait_time = START_SHOOT_SPEED
	shoot_timer.start()
