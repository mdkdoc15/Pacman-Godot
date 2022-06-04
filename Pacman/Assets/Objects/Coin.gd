extends Area2D



func _on_Coin_area_entered(area: Area2D) -> void:
	queue_free()
