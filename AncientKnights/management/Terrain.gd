extends Node2D

const DEFAULT_LAYER: int = 0
const FOAM: PackedScene = preload("res://management/foam.tscn")

@onready var grass_tilemap: TileMap = get_node("Grass")
@onready var water_tilemap: TileMap = get_node("Water")

var grass_used_cells: Array
var water_used_cells: Array

func _ready() -> void:
	var used_grass_rect: Rect2 = grass_tilemap.get_used_rect()
	grass_used_cells = grass_tilemap.get_used_cells(DEFAULT_LAYER)
	generate_water_tiles(used_grass_rect)
	generate_foam_tiles()
	
func generate_water_tiles(used_rec: Rect2) -> void:
	for x in range(used_rec.position.x -10, used_rec.size.x + 10):
		for y in range(used_rec.position.y -10, used_rec.size.y + 10):
			if grass_used_cells.has(Vector2i(x, y)):
				continue
				
			water_tilemap.set_cell(DEFAULT_LAYER, Vector2i(x, y), DEFAULT_LAYER, Vector2i(0, 0))

	water_used_cells = water_tilemap.get_used_cells(DEFAULT_LAYER)

func generate_foam_tiles() -> void:
	for cell in grass_used_cells:
		if check_grass_neighbors(cell):
			spaw_foam(cell)
		
func check_grass_neighbors(cell: Vector2i) -> bool:
	var left_neighbor: Vector2i = Vector2i(cell.x -1, cell.y)
	var right_neighbor: Vector2i = Vector2i(cell.x +1, cell.y)
	var up_neighbor: Vector2i = Vector2i(cell.x, cell.y -1)
	var bottom_neighbor: Vector2i = Vector2i(cell.x, cell.y +1)
	
	var neighboars_list: Array = [left_neighbor, right_neighbor, up_neighbor, bottom_neighbor]
	
	for neighbor in neighboars_list:
		if water_used_cells.has(neighbor):
			return true
	
	return false

func spaw_foam(foam_cell: Vector2) -> void:
	var foam = FOAM.instantiate()
	add_child(foam)
	foam.position = (foam_cell * 64.0) + Vector2(32, 32)
