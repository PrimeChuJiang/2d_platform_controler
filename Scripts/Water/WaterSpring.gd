extends Node2D

class_name WaterSpring

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

# 弹簧当前的速度
var velocity : float = 0

var force : float = 0

var height : float = 0

var index = 0

var motion_factor = 0.01

signal splash
# 弹簧的自然位置
var target_height : float = 0

var collided_with = null

func water_update(sprint_constant : float, dampening : float):
	# 更新当前帧点位置
	height = position.y
	# 计算当前位置和初始位置的差值
	var x = height - target_height
	#if abs(x) < 0.0001 : return
	var loss = -dampening * velocity
	#print(x)
	# 由弹簧的弹力系数得出力大小(胡克定理)
	force = -sprint_constant * x + loss
	#print(force)
	# 
	velocity += force
	#print(velocity)
	position.y += velocity

func initialize(x_position : float, id: int):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
	index = id

func set_collision_width(value):
	var size : Vector2 = collision_shape_2d.shape.get_size()
	var new_extents = Vector2(value, size.y)
	collision_shape_2d.shape.set_size(new_extents)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body == collided_with : return
	collided_with = body
	var speed = body.velocity.y * motion_factor
	emit_signal("splash", index, speed)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	collided_with = null
