extends Area2D
# Code from this is modifyed from https://github.com/IvessJohn/basic-pathfinding-Godot/blob/d08f05970a46c8d8f65a519dfbbe6b91def69f65/Enemy.gd
export var tile_size: = 64 # TODO refactor out
export(int) var SPEED: int = 40

export var time_btwn_moves: = .45


var path: Array = []	# Contains destination positions
var levelNavigation: Navigation2D = null
var player = null
var dir : Vector2 = Vector2.ZERO
onready var line2d = $Line2D
var curr_time :  = 0.0

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]

func _physics_process(delta):
	line2d.global_position = Vector2.ZERO
	curr_time += delta
	if player && curr_time >= time_btwn_moves:
		curr_time = 0
		generate_path()
		navigate()
		move()
	
	
func navigate():	# Define the next position to go to
	if path.size() > 0:
		dir = global_position.direction_to(path[1]) 
		
		# If reached the destination, remove this point from path array
		if global_position == path[0]:
			path.pop_front()

func generate_path():	# It's obvious
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		line2d.points = path

func move():
	position += dir * tile_size
