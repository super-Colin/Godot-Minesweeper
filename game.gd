extends Node2D

var tile_scene = preload("res://tile.tscn")
var grid_size = Vector2(7, 5)
var tile_size = Vector2(100,100)
var half_tile = tile_size.x / 2

var difficulty =3

var gridMatrix =[]

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Tile.setNum("4")
	#spawn_tile(Vector2(100,100))5
	spawn_grid()
	setBombNeighborNumbers()
	Events.popZeros.connect(triggerNeighborZeros)
	pass # Replace with function body.

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("click")):
		print("game clicked")
		Events.click.emit()
		Events.popZeros.connect(triggerNeighborZeros)
	pass



func spawn_tile(position, isBomb=false):
	var new_tile = tile_scene.instantiate()
	new_tile.position = position
	var num = randi() % difficulty
	if num == 0: 
		new_tile.setIsBomb()
		new_tile.setText("")
	else:
		new_tile.setText("0")
	#new_tile.setNumsetText(num)
	$'.'.add_child(new_tile)
	return new_tile



func spawn_grid():
	for row in grid_size.x :
		gridMatrix.append([])
		for column in grid_size.y :
			var tile = spawn_tile(Vector2((row * tile_size.x) - half_tile + tile_size.x, (column * tile_size.y) - half_tile + tile_size.y))
			gridMatrix[row].append(tile)
			tile.setGridPosition(Vector2(row, column))
		
	pass


func setBombNeighborNumbers():
	for x in grid_size.x :
		for y in grid_size.y:
			if gridMatrix[x][y].isBomb:
				# check for and add to neighbor count for the cell above
				if x > 0:
					gridMatrix[x-1][y].incrementBombNeighbors()
				if y > 0:
					gridMatrix[x][y-1].incrementBombNeighbors()
				if x+1 < grid_size.x:
					gridMatrix[x+1][y].incrementBombNeighbors()
				if y+1 < grid_size.y:
					gridMatrix[x][y+1].incrementBombNeighbors()

func triggerNeighborZeros(tileMatrixPosition):
	print("popping zeros ", tileMatrixPosition)
	var x = tileMatrixPosition.x 
	var y = tileMatrixPosition.y 
	if not gridMatrix[x][y].isBomb:
		#print("is bomb")
		if x > 0:
			print("checking x>0 ", x-1, " ", y)
			gridMatrix[x-1][y].triggerCell(true)
		if y > 0:
			print("checking y>0 ", x, " ", y-1)
			gridMatrix[x][y-1].triggerCell(true)
		if x+1 < grid_size.x :
			print("checking x+1 ", x+1, " ", y)
			gridMatrix[x+1][y].triggerCell(true)
		if y+1 < grid_size.y :
			print("checking y+1 ", x, " ", y+1)
			gridMatrix[x][y+1].triggerCell(true)





