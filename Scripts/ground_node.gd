extends StateNode

class_name GroundNode

@export_group("角色对象", "Character")
@export var Charactercharacter : CharacterBody2D
@export_group("移动","Speed")
@export var Speedmax_speed : float
@export var Speedmax_speed_time : float
@export var Speedmax_speed_stop_time : float
@export_group("跳跃","Jump")
@export var Jumpjump_height : float
@export var Jumpjump_air_time : float
@export var Jumpcan_long_jump : bool
@export var Jumplong_jump_multipler : float = 1.5

# TODO: 增加枚举，控制角色状态
# TODO: 需要增加一个开关，控制是否可以进行长跳和短跳

var movement_state : MovementCompConfig.MovementState

var jump_speed : float # 跳跃速度
var accelerate_up : float # 加速加速度
var accelerate_down : float # 减速加速度
var accelerate_v : float # 垂直向下的加速度

func _ready():
	accelerate_up = Speedmax_speed / Speedmax_speed_time # 求加速加速度
	accelerate_down = Speedmax_speed / Speedmax_speed_stop_time # 求减速加速度
	# accelerate_v = 2*abs(jump_speed*Jumpjump_air_time - Jumpjump_height) / pow(Jumpjump_air_time, 2) 
	accelerate_v = (2*Jumpjump_height)/pow(Jumpjump_air_time, 2) # 求垂直加速度
	jump_speed = accelerate_v * Jumpjump_air_time
	prints(accelerate_up, accelerate_down, accelerate_v, jump_speed)

func intro(param = null):
	accelerate_up = Speedmax_speed / Speedmax_speed_time # 求加速加速度
	accelerate_down = Speedmax_speed / Speedmax_speed_stop_time # 求减速加速度
	# accelerate_v = 2*abs(jump_speed*Jumpjump_air_time - Jumpjump_height) / pow(Jumpjump_air_time, 2) 
	accelerate_v = (2*Jumpjump_height)/pow(Jumpjump_air_time, 2) # 求垂直加速度
	jump_speed = accelerate_v * Jumpjump_air_time
	prints(accelerate_up, accelerate_down, accelerate_v, jump_speed)

var total_time : float
func _physics_process(delta):
	if not Charactercharacter.is_on_floor():
		if Charactercharacter.velocity.y < jump_speed:
			Charactercharacter.velocity.y = move_toward(Charactercharacter.velocity.y, jump_speed, accelerate_v*delta)
		else :
			# Charactercharacter.velocity.y = move_toward(Charactercharacter.velocity.y, jump_speed * 2, accelerate_v*delta)
			Charactercharacter.velocity.y += accelerate_v * delta
		print(Charactercharacter.velocity.y)
		total_time += delta
		print(total_time)

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0 and direction * Charactercharacter.velocity.x >= 0:
		Charactercharacter.velocity.x = move_toward(Charactercharacter.velocity.x, Speedmax_speed*direction, accelerate_up*delta)
	else :
		if not Charactercharacter.is_on_floor() :
			Charactercharacter.velocity.x = move_toward(Charactercharacter.velocity.x, 0, accelerate_up*delta)
		else:
			total_time = 0.0
			Charactercharacter.velocity.x = move_toward(Charactercharacter.velocity.x, 0, accelerate_down*delta)

	if Input.is_action_just_pressed("ui_up"):
		Charactercharacter.velocity.y = -jump_speed
		#print(Charactercharacter.velocity.y)
	#Charactercharacter.move_and_slide()

func count_attribute():
	accelerate_up = Speedmax_speed / Speedmax_speed_time # 求加速加速度
	accelerate_down = Speedmax_speed / Speedmax_speed_stop_time # 求减速加速度
	# accelerate_v = 2*abs(jump_speed*Jumpjump_air_time - Jumpjump_height) / pow(Jumpjump_air_time, 2) 
	accelerate_v = (2*Jumpjump_height)/pow(Jumpjump_air_time, 2) # 求垂直加速度
	jump_speed = accelerate_v * Jumpjump_air_time
	prints(accelerate_up, accelerate_down, accelerate_v, jump_speed)
