extends Node2D

const BLOCK_1: Texture2D = preload("res://assets/bunker/bottom_block_01.png")
const BLOCK_2: Texture2D = preload("res://assets/bunker/bottom_block_02.png")
const BLOCK_3: Texture2D = preload("res://assets/bunker/bottom_block_03.png")
const BOTTOM_CORNER_1: Texture2D = preload("res://assets/bunker/corner_bottom_01.png")
const BOTTOM_CORNER_2: Texture2D = preload("res://assets/bunker/corner_bottom_02.png")
const BOTTOM_CORNER_3: Texture2D = preload("res://assets/bunker/corner_bottom_03.png")
const TOP_CORNER_1: Texture2D = preload("res://assets/bunker/corner_left_01.png")
const TOP_CORNER_2: Texture2D = preload("res://assets/bunker/corner_left_02.png")
const TOP_CORNER_3: Texture2D = preload("res://assets/bunker/corner_left_03.png")
const MIDDLE_BLOCK_1: Texture2D = preload("res://assets/bunker/middle_block_01.png")
const MIDDLE_BLOCK_2: Texture2D = preload("res://assets/bunker/middle_block_02.png")
const MIDDLE_BLOCK_3: Texture2D = preload("res://assets/bunker/middle_block_03.png")

var bottom_left_life: int = 3
var bottom_left_life_2: int = 3
var bottom_left_corner_life: int = 3
var top_left_corner_life: int = 3
var top_left_life: int = 3
var bottom_right_life: int = 3
var bottom_right_life_2: int = 3
var bottom_right_corner_life: int = 3
var top_right_corner_life: int = 3
var top_right_life: int = 3
var middle_life: int = 3

@onready var bottom_left_sprite_2d: Sprite2D = %BottomLeftSprite2D
@onready var bottom_left_sprite_2d_2: Sprite2D = %BottomLeftSprite2D2
@onready var bottom_left_corner_sprite_2d: Sprite2D = %BottomLeftCornerSprite2D
@onready var top_left_corner_sprite_2d: Sprite2D = %TopLeftCornerSprite2D
@onready var top_left_sprite_2d: Sprite2D = %TopLeftSprite2D
@onready var bottom_right_sprite_2d: Sprite2D = %BottomRightSprite2D
@onready var bottom_right_sprite_2d_2: Sprite2D = %BottomRightSprite2D2
@onready var bottom_right_corner_sprite_2d: Sprite2D = %BottomRightCornerSprite2D
@onready var top_right_corner_sprite_2d: Sprite2D = %TopRightCornerSprite2D
@onready var top_right_sprite_2d: Sprite2D = %TopRightSprite2D
@onready var middle_sprite_2d: Sprite2D = %MiddleSprite2D
@onready var bottom_left_area_2d: Area2D = %BottomLeftArea2D
@onready var bottom_left_area_2d_2: Area2D = %BottomLeftArea2D2
@onready var bottom_left_corner_area_2d: Area2D = %BottomLeftCornerArea2D
@onready var top_left_corner_area_2d: Area2D = %TopLeftCornerArea2D
@onready var top_left_area_2d: Area2D = %TopLeftArea2D
@onready var bottom_right_area_2d: Area2D = %BottomRightArea2D
@onready var bottom_right_area_2d_2: Area2D = %BottomRightArea2D2
@onready var bottom_right_corner_area_2d: Area2D = %BottomRightCornerArea2D
@onready var top_right_corner_area_2d: Area2D = %TopRightCornerArea2D
@onready var top_right_area_2d: Area2D = %TopRightArea2D
@onready var middle_area_2d: Area2D = %MiddleArea2D


func reset():
	bottom_left_life = 3
	bottom_left_life_2 = 3
	bottom_left_corner_life = 3
	top_left_corner_life = 3
	top_left_life = 3
	bottom_right_life = 3
	bottom_right_life_2 = 3
	bottom_right_corner_life = 3
	top_right_corner_life = 3
	top_right_life = 3
	middle_life = 3
	
	bottom_left_sprite_2d.texture = BLOCK_1
	bottom_left_sprite_2d_2.texture = BLOCK_1
	bottom_left_corner_sprite_2d.texture = BOTTOM_CORNER_1
	top_left_corner_sprite_2d.texture = TOP_CORNER_1
	top_left_sprite_2d.texture = BLOCK_1
	bottom_right_sprite_2d.texture = BLOCK_1
	bottom_right_sprite_2d_2.texture = BLOCK_1
	bottom_right_corner_sprite_2d.texture = BOTTOM_CORNER_1
	top_right_corner_sprite_2d.texture = TOP_CORNER_1
	top_right_sprite_2d.texture = BLOCK_1
	middle_sprite_2d.texture = MIDDLE_BLOCK_1
	
	bottom_left_sprite_2d.visible = true
	bottom_left_sprite_2d_2.visible = true
	bottom_left_corner_sprite_2d.visible = true
	top_left_corner_sprite_2d.visible = true
	top_left_sprite_2d.visible = true
	bottom_right_sprite_2d.visible = true
	bottom_right_sprite_2d_2.visible = true
	bottom_right_corner_sprite_2d.visible = true
	top_right_corner_sprite_2d.visible = true
	top_right_sprite_2d.visible = true
	middle_sprite_2d.visible = true
	
	bottom_left_area_2d.monitoring = true
	bottom_left_area_2d_2.monitoring = true
	bottom_left_corner_area_2d.monitoring = true
	top_left_corner_area_2d.monitoring = true
	top_left_area_2d.monitoring = true
	bottom_right_area_2d.monitoring = true
	bottom_right_area_2d_2.monitoring = true
	bottom_right_corner_area_2d.monitoring = true
	top_right_corner_area_2d.monitoring = true
	top_right_area_2d.monitoring = true
	middle_area_2d.monitoring = true


func _on_bottom_left_area_2d_body_entered(body):
	body.queue_free()
	bottom_left_life -= 1
	
	if bottom_left_life == 0:
		bottom_left_area_2d.set_deferred("monitoring", false)
		
	match bottom_left_life:
		2:
			bottom_left_sprite_2d.texture = BLOCK_2
		1:
			bottom_left_sprite_2d.texture = BLOCK_3
		0:
			bottom_left_sprite_2d.visible = false


func _on_bottom_left_area_2d_2_body_entered(body):
	body.queue_free()
	bottom_left_life_2 -= 1
	
	if bottom_left_life_2 == 0:
		bottom_left_area_2d_2.set_deferred("monitoring", false)
		
	match bottom_left_life_2:
		2:
			bottom_left_sprite_2d_2.texture = BLOCK_2
		1:
			bottom_left_sprite_2d_2.texture = BLOCK_3
		0:
			bottom_left_sprite_2d_2.visible = false


func _on_bottom_left_corner_area_2d_body_entered(body):
	body.queue_free()
	bottom_left_corner_life -= 1
	
	if bottom_left_corner_life == 0:
		bottom_left_corner_area_2d.set_deferred("monitoring", false)
		
	match bottom_left_corner_life:
		2:
			bottom_left_corner_sprite_2d.texture = BOTTOM_CORNER_2
		1:
			bottom_left_corner_sprite_2d.texture = BOTTOM_CORNER_3
		0:
			bottom_left_corner_sprite_2d.visible = false


func _on_top_left_corner_area_2d_body_entered(body):
	body.queue_free()
	top_left_corner_life -= 1
	
	if top_left_corner_life == 0:
		top_left_corner_area_2d.set_deferred("monitoring", false)
		
	match top_left_corner_life:
		2:
			top_left_corner_sprite_2d.texture = TOP_CORNER_2
		1:
			top_left_corner_sprite_2d.texture = TOP_CORNER_3
		0:
			top_left_corner_sprite_2d.visible = false


func _on_top_left_area_2d_body_entered(body):
	body.queue_free()
	top_left_life -= 1
	
	if top_left_life == 0:
		top_left_area_2d.set_deferred("monitoring", false)
		
	match top_left_life:
		2:
			top_left_sprite_2d.texture = BLOCK_2
		1:
			top_left_sprite_2d.texture = BLOCK_3
		0:
			top_left_sprite_2d.visible = false


func _on_bottom_right_area_2d_body_entered(body):
	body.queue_free()
	bottom_right_life -= 1
	
	if bottom_right_life == 0:
		bottom_right_area_2d.set_deferred("monitoring", false)
		
	match bottom_right_life:
		2:
			bottom_right_sprite_2d.texture = BLOCK_2
		1:
			bottom_right_sprite_2d.texture = BLOCK_3
		0:
			bottom_right_sprite_2d.visible = false


func _on_bottom_right_area_2d_2_body_entered(body):
	body.queue_free()
	bottom_right_life_2 -= 1
	
	if bottom_right_life_2 == 0:
		bottom_right_area_2d_2.set_deferred("monitoring", false)
		
	match bottom_right_life_2:
		2:
			bottom_right_sprite_2d_2.texture = BLOCK_2
		1:
			bottom_right_sprite_2d_2.texture = BLOCK_3
		0:
			bottom_right_sprite_2d_2.visible = false


func _on_bottom_right_corner_area_2d_body_entered(body):
	body.queue_free()
	bottom_right_corner_life -= 1
	
	if bottom_right_corner_life == 0:
		bottom_right_corner_area_2d.set_deferred("monitoring", false)
		
	match bottom_right_corner_life:
		2:
			bottom_right_corner_sprite_2d.texture = BOTTOM_CORNER_2
		1:
			bottom_right_corner_sprite_2d.texture = BOTTOM_CORNER_3
		0:
			bottom_right_corner_sprite_2d.visible = false


func _on_top_right_corner_area_2d_body_entered(body):
	body.queue_free()
	top_right_corner_life -= 1
	
	if top_right_corner_life == 0:
		top_right_corner_area_2d.set_deferred("monitoring", false)
		
	match top_right_corner_life:
		2:
			top_right_corner_sprite_2d.texture = TOP_CORNER_2
		1:
			top_right_corner_sprite_2d.texture = TOP_CORNER_3
		0:
			top_right_corner_sprite_2d.visible = false


func _on_top_right_area_2d_body_entered(body):
	body.queue_free()
	top_right_life -= 1
	
	if top_right_life == 0:
		top_right_area_2d.set_deferred("monitoring", false)
		
	match top_right_life:
		2:
			top_right_sprite_2d.texture = BLOCK_2
		1:
			top_right_sprite_2d.texture = BLOCK_3
		0:
			top_right_sprite_2d.visible = false


func _on_middle_area_2d_body_entered(body):
	body.queue_free()
	middle_life -= 1
	
	if middle_life == 0:
		middle_area_2d.set_deferred("monitoring", false)
		
	match middle_life:
		2:
			middle_sprite_2d.texture = MIDDLE_BLOCK_2
		1:
			middle_sprite_2d.texture = MIDDLE_BLOCK_3
		0:
			middle_sprite_2d.visible = false
