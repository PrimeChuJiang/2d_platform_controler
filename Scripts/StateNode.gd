extends Node2D

class_name StateNode

@export var state_node_type : MovementCompConfig.MovementState

signal change_state(from : StateNode, to : StateNode, param)

func intro(param = null):
	pass

func outro(param = null):
	pass

func tick(delta : float):
	pass

func physics_tick(delta : float):
	pass

func input(event : InputEvent):
	pass
