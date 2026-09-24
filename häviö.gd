extends Node2D

func _aloita_uusi_peli() -> void:
	get_tree().change_scene_to_file("res://mainmenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ok_nappi = get_node("OK")
	ok_nappi.pressed.connect(_aloita_uusi_peli)
	
	var musika: AudioStreamPlayer = get_node("AudioStreamPlayer")
	musika.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
