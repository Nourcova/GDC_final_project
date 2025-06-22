extends Node

@onready var points_label = %"Points Label"

var points = 0

func add_point():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)
