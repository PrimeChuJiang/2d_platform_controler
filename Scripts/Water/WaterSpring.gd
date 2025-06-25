extends Node2D

class_name WaterSpring

# 弹簧当前的速度
var velocity : float = 0

var force : float = 0

var height : float = 0

# 弹簧的自然位置
var target_height : float = 0

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

func initialize(x_position : float):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
