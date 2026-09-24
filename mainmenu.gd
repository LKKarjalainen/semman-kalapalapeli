extends Node2D

var latausnäyttö = preload("res://latausnäyttö.tscn").instantiate()
var häviö = preload("res://häviö.tscn").instantiate()

@onready var pyörivät_kalapuikot = [get_node("Kalapuikko1"), get_node("Kalapuikko2")]

func _häviä_peli():
	get_tree().root.add_child(häviö)
	pass

func _aloita_peli():
	get_tree().root.add_child(latausnäyttö)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var kyllä_nappi = get_node("Kyllä")
	kyllä_nappi.pressed.connect(_aloita_peli)
	var ei_nappi = get_node("Ei")
	ei_nappi.pressed.connect(_häviä_peli)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for kalapuikko in pyörivät_kalapuikot:
		kalapuikko.rotation_degrees += 2.5
	
	pass
