extends Node2D

class_name StateMachine

@export var character : CharacterBody2D
@export var default_node : StateNode

var state_dic : Dictionary[MovementCompConfig.MovementState, StateNode]
var current_state : StateNode

func _ready():
	print("开始寻找所有子节点")
	var node_list : Array[Node] = get_children()
	for node in node_list:
		if node is StateNode:
			state_dic[node.state_node_type] = node
			node.change_state.connect(_change_state)
			node.character = character
			
	if default_node == null : 
		# 如果没有指定默认节点，那么我们将字典内的第一个状态作为默认状态
		default_node = state_dic[state_dic.keys()[0]]
	
	current_state = default_node
	current_state.intro()
	

func _change_state(from : StateNode, to : StateNode, param = null):
	if to == null:
		push_error("StateMachine _change_state()函数内的to参数为空！！！")
		return
	if from == null:
		push_error("StateMachine _change_state()函数内的from参数为空！！！")
		return
	from.outro(param)
	to.intro(param)
	current_state = to

func _process(delta):
	if Engine.is_editor_hint():
		return
	else:
		current_state.tick(delta)

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	else:
		current_state.physics_tick(delta)

func _input(event):
	current_state.input(event)
