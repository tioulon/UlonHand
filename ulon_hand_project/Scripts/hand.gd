extends Node2D

@export var animation: AnimationPlayer
var animation_seek : float = 0
var last_mouse_pos : Vector2 = Vector2.ZERO

@export var arm_dir_marker : Marker2D
@export var arm: Node2D
@export var sprite_parent: Node2D

@export var bottom_aro: Sprite2D
@export var top_aro: Sprite2D
@export var fluffy: Sprite2D

var spdx : float = 0.0
var spdx_fluffy : float = 0.0

func _ready() -> void:
	animation.play("Offset")
	pass # Replace with function body.


func _process(_delta: float) -> void:
	set_position_to_cursor()
	var mouse_event : Vector2 = get_global_mouse_position() - last_mouse_pos
	animation_seek = lerp(animation_seek, clamp(animation.current_animation_position + (mouse_event.x + mouse_event.y)*.05, 0.1, .99), .1)
	animation.seek(animation_seek)
	last_mouse_pos = get_global_mouse_position()
	
	arm.global_rotation = (arm_dir_marker.global_position - arm.global_position).angle() - PI/2
	sprite_parent.rotation_degrees = 7 + (70 * (global_position.x / 1920))
	
	#bottom_aro.global_rotation_degrees = lerp(bottom_aro.global_rotation_degrees, 0.0, .1)
	#top_aro.global_rotation_degrees = lerp(top_aro.global_rotation_degrees, 0.0, .1)
	
	spdx_fluffy = lerp(spdx_fluffy, (0 - fluffy.global_rotation_degrees) * .15, .05)
	spdx = lerp(spdx, (0 - bottom_aro.global_rotation_degrees) * .15, .05)
	bottom_aro.global_rotation_degrees += spdx
	top_aro.global_rotation_degrees += spdx
	fluffy.global_rotation_degrees += spdx_fluffy
	pass

#--------------------------------


func set_position_to_cursor() -> void:
	global_position = get_global_mouse_position()
	pass
