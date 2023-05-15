extends Label

var mainScript = null

func _ready():
	if get_tree().has_singleton("MainDisplay"):
		mainScript = get_tree().get_singleton("MainDisplay")

func _process(delta):
	if mainScript != null:
		var fileName = mainScript.getSquareFileName()
		# Use the fileName as needed in your Square scene script
