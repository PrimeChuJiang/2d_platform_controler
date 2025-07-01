extends Node2D

@onready var water_polygon: Polygon2D = $WaterPolygon
@onready var water_spring : PackedScene = preload("res://Scenes/Water/WaterSpring.tscn")
@onready var water_border: SmoothPath = $WaterBorder


@export var k = 0.015
@export var d = 0.03
@export var spread = 0.0002
# 每个弹簧间的距离
@export var distance_between_springs : int = 32
# 弹簧个数
@export var spring_number : int = 6
@export var depth : float = 1000
# 水面横截面宽度
@export var border_thickness = 1.1

var target_height = global_position.y
var bottom = target_height + depth
var springs : Array[WaterSpring] = []
var passes : float = 8

func _ready() -> void:
	water_border.width = border_thickness
	
	for i in range(spring_number):
		var x_position : float = distance_between_springs * i
		var w : WaterSpring = water_spring.instantiate()
		add_child(w)
		springs.append(w)
		w.initialize(x_position, i)
		w.set_collision_width(distance_between_springs)
		w.splash.connect(splash)
		
	#splash(2, 5)

func _physics_process(delta: float) -> void:
	for item in springs:
		item.water_update(k, d)
	var left_deltas : Array = []
	var right_deltas : Array = []
	
	for i in range(springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
	
	for j in range(passes):
		for i in range(springs.size()):
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			if i < springs.size()-1:
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
	new_border()
	draw_water_body()

func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed

func draw_water_body():
	var curve : Curve2D = water_border.curve
	var points = Array(curve.get_baked_points())
	
	var water_polygon_points = points

	var first_index = 0
	var last_index = springs.size()-1
	
	
	water_polygon_points.append(Vector2(water_polygon_points[last_index].x, bottom))
	water_polygon_points.append(Vector2(water_polygon_points[first_index].x, bottom))
	
	water_polygon_points = PackedVector2Array(water_polygon_points)
	
	water_polygon.set_polygon(water_polygon_points)

func new_border():
	var curve : Curve2D = Curve2D.new().duplicate()
	var surface_points : Array[Vector2] = []
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
	
	for i in range(surface_points.size()):
		curve.add_point(surface_points[i])
	
	water_border.curve = curve
	water_border.smooth(true)
	water_border.queue_redraw()
