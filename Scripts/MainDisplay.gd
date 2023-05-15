extends Node2D

var entity = preload("res://Entities/Square.tscn") # Load the Square scene
var file_path = "" # Set the file path to an empty string initially
var coords = Vector2.ZERO # Set the initial coordinates to (0,0)

func _ready():
	var files = Directory.new()
	files.open("res://") # Open the resource directory
	files.list_dir_begin() # Begin listing the files in the resource directory
	while true:
		var file_name = files.get_next() # Get the next file name
		if file_name == "":
			break # Stop if there are no more files
		if file_name.get_extension() == "txt":
			file_path = "res://" + file_name # Set the file path to the first .txt file found
			break # Stop after finding the first .txt file
	files.list_dir_end() # End listing the files in the resource directory

	read_coordinates() # Read the initial coordinates from the text file
	var square = entity.instance() # Instantiate the Square scene
	add_child(square) # Add the Square as a child of this Node2D
	square.position = coords # Set the position of the Square to the current coordinates

var timer = 1.0 # Set the timer to 1 second
func _process(delta):
	timer -= delta # Decrement the timer every frame
	if timer <= 0.0:
		read_coordinates() # Read the latest coordinates from the text file
		get_node("Square").position = coords # Update the position of the Square to the current coordinates
		timer = 1.0 # Reset the timer to 1 second

func read_coordinates():
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		var line = file.get_line().strip_edges()
		while line != "":
			var temp = line.split(",")
			coords = Vector2(float(temp[0]), float(temp[1]))
			line = file.get_line().strip_edges()
		file.close()
