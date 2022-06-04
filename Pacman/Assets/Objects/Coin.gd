extends Area2D

export var tile_size: = 64 # TODO refactor out

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	

func _on_Coin_area_entered(area: Area2D) -> void:
	queue_free()
