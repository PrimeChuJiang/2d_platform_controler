extends Node2D

@export_group("角色对象", "Character")
@export var Charactercharacter : CharacterBody2D
@export_group("速度","Speed")
@export var Speedmax_speed : float
@export var Speedmax_speed_time : float
@export var Speedmax_speed_stop_time : float

var accelerate_up : float # 加速加速度
var accelerate_down : float # 减速加速度

func _ready():
	accelerate_up = Speedmax_speed / Speedmax_speed_time # 求加速加速度
	accelerate_down = Speedmax_speed / Speedmax_speed_stop_time # 求减速加速度

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	#print(direction)
	if direction != 0 and direction * Charactercharacter.velocity.x >= 0:
		Charactercharacter.velocity.x = move_toward(Charactercharacter.velocity.x, Speedmax_speed*direction, accelerate_up*delta)
		print(Charactercharacter.velocity.x)
	else :
		Charactercharacter.velocity.x = move_toward(Charactercharacter.velocity.x, 0, accelerate_down*delta)
	#Charactercharacter.move_and_slide()

func _process(delta):
	pass
