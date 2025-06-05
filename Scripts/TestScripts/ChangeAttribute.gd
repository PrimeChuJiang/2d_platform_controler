extends Control

@export var move_comp : MovementComponent

@export var max_speed_time : TextEdit
@export var max_speed_stop_time : TextEdit
@export var max_speed : TextEdit
@export var jump_height : TextEdit
@export var jump_air_time : TextEdit

func _ready():
	max_speed_time.text = str(move_comp.Speedmax_speed_time)
	max_speed_stop_time.text = str(move_comp.Speedmax_speed_stop_time)
	max_speed.text = str(move_comp.Speedmax_speed)
	jump_height.text = str(move_comp.Jumpjump_height)
	jump_air_time.text = str(move_comp.Jumpjump_air_time)
	max_speed_time.text_changed.connect(_change_max_speed_time)
	max_speed_stop_time.text_changed.connect(_change_max_speed_stop_time)
	max_speed.text_changed.connect(_change_max_speed)
	jump_height.text_changed.connect(_change_jump_height)
	jump_air_time.text_changed.connect(_change_jump_air_time)

func _change_max_speed_time():
	move_comp.Speedmax_speed_time = max_speed_time.text.to_float()
	move_comp.count_attribute()

func _change_max_speed_stop_time():
	move_comp.Speedmax_speed_stop_time = max_speed_stop_time.text.to_float()
	move_comp.count_attribute()

func _change_max_speed():
	move_comp.Speedmax_speed = max_speed.text.to_float()
	move_comp.count_attribute()

func _change_jump_height():
	move_comp.Jumpjump_height = jump_height.text.to_float()
	move_comp.count_attribute()
	
func _change_jump_air_time():
	move_comp.Jumpjump_air_time = jump_air_time.text.to_float()
	move_comp.count_attribute()
