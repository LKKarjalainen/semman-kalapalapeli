extends Node2D


@onready var kalapala: Sprite2D = get_node("Kalapala")
@onready var ajastin: Timer = get_node("Timer")

var kalapalan_koko: Vector2

func _ladattu() -> void:
	get_tree().change_scene_to_file("res://valinta.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	kalapalan_koko = kalapala.texture.get_size()
	kalapala.position -= kalapalan_koko * kalapala.scale / 2

	var musika: AudioStreamPlayer = get_node("AudioStreamPlayer")
	musika.play()

	ajastin.start()
	ajastin.timeout.connect(_ladattu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var edistys := 1.0 - ajastin.time_left / ajastin.wait_time
	kalapala.region_rect = Rect2(0, 0, kalapalan_koko.x * edistys, kalapalan_koko.y)
