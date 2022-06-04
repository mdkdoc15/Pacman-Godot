extends Area2D
# Tile based movement found at https://kidscancode.org/godot_recipes/2d/grid_movement/
onready var ray : RayCast2D = $RayCast2D
onready var sprite : Sprite = $Icon
export var time_btwn_moves : float = .2


export var tile_size: = 64

var current_dir = Vector2.ZERO

var curr_time : float = 0

var inputs = { "right" : Vector2.RIGHT,
			"left" : Vector2.LEFT,
			"up" : Vector2.UP,
			"down" : Vector2.DOWN
			}
# Rotation amount is in radians
var rotation_amount = {  Vector2.RIGHT : 0,
			 Vector2.LEFT : -PI,
			Vector2.UP : -PI/2,
			Vector2.DOWN : PI/2
			}

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position -= Vector2.ONE * tile_size/2
	
func _unhandled_input(event: InputEvent) -> void:
	if curr_time >= time_btwn_moves:
		curr_time = 0
		for dir in inputs.keys():
			if event.is_action(dir):
				current_dir = inputs[dir]
				move(current_dir)
	
	
func _physics_process(delta: float) -> void:
	curr_time += delta
	

func move(dir : Vector2) -> void:
	ray.cast_to = dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += dir * tile_size
		sprite.rotation = rotation_amount[dir]		# Point pacman in the right direction
		
