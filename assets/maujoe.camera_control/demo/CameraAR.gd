extends Node2D

#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func _draw():
	var col = Color(1,0,0)
	var rect = Rect2(Vector2(0,0),Vector2(1000,1000))
	draw_rect(rect, col)

