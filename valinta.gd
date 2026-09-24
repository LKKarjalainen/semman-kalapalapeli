extends Node2D

@onready var ajastin: Timer = get_node("Timer")
@onready var lautanen: Sprite2D = get_node("Lautanen")
@onready var lentävät: Array[Sprite2D] = [get_node("Kalapala"), get_node("Kala"), get_node("Ankkuri"), get_node("Tähti")]
@onready var musika: AudioStreamPlayer = get_node("AudioStreamPlayer")
@onready var warning: AudioStreamPlayer = get_node("warning")


const LENTOAIKA := 1.2
const PYÖRÄHDYKSET := 2

var kalapalat: int = 0

func _ota_kalapala() -> void:
	if kalapalat < lentävät.size():
		_lennätä_lautaselle(lentävät[kalapalat])
	kalapalat += 1
	if kalapalat > 3:
		_häviä_peli()

func _älä_ota_kalapala() -> void:
	if kalapalat == 3:
		get_tree().change_scene_to_file("res://voitto.tscn")
	else:
		_häviä_peli()

func _häviä_peli() -> void:
	get_node("Vihanen").visible = true
	get_node("mitä").visible = true
	musika.stop()
	warning.play()
	ajastin.start()
	ajastin.timeout.connect(_vaihda_scene)

func _vaihda_scene() -> void:
	get_tree().change_scene_to_file("res://häviö.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var kyllä_nappi = get_node("Kyllä")
	kyllä_nappi.pressed.connect(_ota_kalapala)
	var ei_nappi = get_node("Ei")
	ei_nappi.pressed.connect(_älä_ota_kalapala)
	
	musika.play()

func _lennätä_lautaselle(kuva: Sprite2D) -> void:
	# Draw on top of the plate
	kuva.z_index = 1
	# Land slightly apart so they don't all stack on the exact same spot
	var kohde := lautanen.position + Vector2(randf_range(-80, 80), randf_range(-60, 60))
	var loppukulma := randf_range(-0.4, 0.4)

	var tween := create_tween().set_parallel()
	tween.tween_property(kuva, "position", kohde, LENTOAIKA) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(kuva, "rotation", loppukulma + TAU * PYÖRÄHDYKSET, LENTOAIKA) \
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
