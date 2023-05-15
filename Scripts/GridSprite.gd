extends Node2D

export var gridColor: Color = Color(0.5, 0.5, 0.5, 0.2)
export var gridSize: int = 1000
export var gridSpacing: int = 1

func _draw():
	var startX = -50000
	var startY = -50000

	var endX = 50000
	var endY = 50000

	var currentX = startX
	var currentY = startY

	# Draw vertical lines
	while currentX <= endX:
		draw_line(Vector2(currentX, startY), Vector2(currentX, endY), gridColor)
		currentX += gridSize * gridSpacing

	# Draw horizontal lines
	while currentY <= endY:
		draw_line(Vector2(startX, currentY), Vector2(endX, currentY), gridColor)
		currentY += gridSize * gridSpacing
