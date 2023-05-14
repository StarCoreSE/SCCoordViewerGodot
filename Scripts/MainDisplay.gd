extends Node2D

var timer = 1.0 # Set the timer to 1 second
var entity = preload("res://Entities/Square.tscn") # Load the Square scene
var file_path = "res://coordinates.txt" # Set the file path to the text file
var coords = Vector2.ZERO # Set the initial coordinates to (0,0,0)

func _process(delta):
	timer -= delta # Decrement the timer every frame
	if timer <= 0.0:
		var square = entity.instance() # Instantiate the Square scene
		add_child(square) # Add the Square as a child of this Node2D
		square.position = coords # Set the position of the Square to the current coordinates
		timer = 1.0 # Reset the timer to 1 second
		read_coordinates() # Read the latest coordinates from the text file

func read_coordinates():
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		while !file.eof_reached():
			var line = file.get_line().strip_edges()
			if line != "":
				var temp = line.split(",")
				coords = Vector2(float(temp[0]), float(temp[1]))
		file.close()

func _ready():
	read_coordinates() # Read the initial coordinates from the text file
