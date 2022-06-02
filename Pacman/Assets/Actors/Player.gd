extends Area2D
# Tile based movement found at https://kidscancode.org/godot_recipes/2d/grid_movement/
onready var ray : RayCast2D = $RayCast2D

export var tile_size: = 64

var current_dir = Vector2.ZERO

var inputs = { "right" : Vector2.RIGHT,
			"left" : Vector2.LEFT,
			"up" : Vector2.UP,
			"down" : Vector2.DOWN
			}
			

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	
func _unhandled_input(event: InputEvent) -> void:
	var entered : = false
	for dir in inputs.keys():
		if event.is_action(dir):
			current_dir = inputs[dir]
			move(current_dir)
	
	

func move(dir : Vector2) -> void:
	ray.cast_to = dir * tile_size 	# Cast ray
	ray.force_raycast_update() 				# Force ray to cast this frame
	if !ray.is_colliding(): 					# Check for collision
		position += dir * tile_size
