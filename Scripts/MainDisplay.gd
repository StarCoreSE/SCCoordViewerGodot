extends Node2D

var entity = preload("res://Entities/Square.tscn") # Load the Square scene
var file_path = "res://coordinates.txt" # Set the file path to the text file
var coords = Vector2.ZERO # Set the initial coordinates to (0,0)

func _ready():
	read_coordinates() # Read the initial coordinates from the text file
	if coords != Vector2.ZERO: # Check if coordinates were successfully read
		var square = entity.instance() # Instantiate the Square scene
		add_child(square) # Add the Square as a child of this Node2D
		square.position = coords # Set the position of the Square to the current coordinates

var timer = 1.0 # Set the timer to 1 second
func _process(delta):
	timer -= delta # Decrement the timer every frame
	if timer <= 0.0:
		read_coordinates() # Read the latest coordinates from the text file
		if coords != Vector2.ZERO: # Check if coordinates were successfully read
			get_node("Square").position = coords # Update the position of the Square to the current coordinates
		timer = 1.0 # Reset the timer to 1 second

func read_coordinates():
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		var line = file.get_line().strip_edges()
		while line != "":
			if line.find("position:") != -1: # Check if line contains "position:"
				var x_pos = line.find("X=") + 2 # Find index of X coordinate
				var y_pos = line.find("Y=") + 2 # Find index of Y coordinate
				var comma_pos = line.find(",", y_pos) # Find index of comma after Y coordinate
				var x_coord = float(line.substr(x_pos, y_pos - x_pos - 2)) # Extract X coordinate
				var y_coord = float(line.substr(y_pos, comma_pos - y_pos)) # Extract Y coordinate
				coords = Vector2(x_coord, y_coord) # Update coords
			line = file.get_line().strip_edges()
		file.close()
	else:
		coords = Vector2.ZERO # Set coords to (0,0) if file doesn't exist or can't be read
