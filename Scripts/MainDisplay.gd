extends Node2D

var entity = preload("res://Entities/Square.tscn") # Load the Square scene

func _ready():
	var dir = Directory.new()
	dir.open("res://")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".txt"):
			var coords = read_coordinates("res://" + file_name)
			if coords != Vector2.ZERO:
				var square = entity.instance() # Instantiate the Square scene
				add_child(square) # Add the Square as a child of this Node2D
				square.position = coords # Set the position of the Square to the current coordinates
				square.name = file_name.substr(0, file_name.length() - 4) # Set the name of the Square to the file name (without the .txt extension)
		file_name = dir.get_next()
	dir.list_dir_end()

var timer = 1.0 # Set the timer to 1 second
func _process(delta):
	timer -= delta # Decrement the timer every frame
	if timer <= 0.0:
		var dir = Directory.new()
		dir.open("res://")
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".txt"):
				var coords = read_coordinates("res://" + file_name)
				if coords != Vector2.ZERO:
					var square = get_node(file_name.substr(0, file_name.length() - 4)) # Find the node with the same name as the file (without the .txt extension)
					if square == null:
						square = entity.instance() # Instantiate the Square scene
						add_child(square) # Add the Square as a child of this Node2D
						square.name = file_name.substr(0, file_name.length() - 4) # Set the name of the Square to the file name (without the .txt extension)
					if square != null: # Check if node exists before updating position
						square.position = coords # Update the position of the Square to the current coordinates
			file_name = dir.get_next()
		dir.list_dir_end()
		timer = 1.0 # Reset the timer to 1 second


func read_coordinates(file_path):
	var coords = Vector2.ZERO # Set the initial coordinates to (0,0)
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
	return coords # Return the coordinates read from the file
