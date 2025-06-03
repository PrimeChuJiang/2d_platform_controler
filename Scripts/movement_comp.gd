extends Node2D

@export_group("角色对象", "Character")
@export var Charactercharacter : CharacterBody2D
@export_group("移动","Speed")
@export var Speedmax_speed : float
@export var Speedmax_speed_time : float
@export var Speedmax_speed_stop_time : float
@export_group("跳跃","Jump")
@export var Jumpjump_height : float
@export var Jumpjump_air_time : float
@export var Jumpfall_max_speed : float
@export var Jumpjump_speed : float

var accelerate_up : float # 加速加速度
var accelerate_down : float # 减速加速度
var accelerate_v : float # 垂直向下的加速度

func _ready():
	accelerate_up = Speedmax_speed / Speedmax_speed_time # 求加速加速度
	accelerate_down = Speedmax_speed / Speedmax_speed_stop_time # 求减速加速度
	accelerate_v = 2*(Jumpjump_height - Jumpjump_speed*Jumpjump_air_time) / pow(Jumpjump_air_time, 2) # 求垂直加速度
	

func _physics_process(delta):
	if (not Charactercharacter.is_on_floor()) and Charactercharacter.velocity.y > -Jumpfall_max_speed:
		Charactercharacter.velocity.y = move_toward(Charactercharacter.velocity.y, -Jumpfall_max_speed, accelerate_v*delta)
	
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0 and direction * Charactercharacter.velocity.x >= 0:
		Charactercharacter.velocity.x = move_toward(Charactercharacter.velocity.x, Speedmax_speed*direction, accelerate_up*delta)
		print(Charactercharacter.velocity.x)
	else :
		Charactercharacter.velocity.x = move_toward(Charactercharacter.velocity.x, 0, accelerate_down*delta)
	
	if Input.is_action_just_pressed("ui_up"):
		Charactercharacter.velocity.y = -Jumpjump_speed
		print(Charactercharacter.velocity.y)
	#Charactercharacter.move_and_slide()

func _process(delta):
	pass
