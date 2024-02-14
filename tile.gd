extends Area2D


var isBomb = false
var grid_position = Vector2(0, 0)
var printed = 0

var bombNeighbors = 0

var popped = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#connect("mouse_entered",inFocus)
	#connect("mouse_exited",outOfFocus)
	#connect("click", clicked)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func setText(text=""):
	#$Label.text = ("%d" % num)
	$Label.text = text
	
func setIsBomb():
	isBomb = true
	#print(grid_position, " cell is a bomb, num is: ", num)

func setGridPosition(pos):
	grid_position = pos

func incrementBombNeighbors():
	if not isBomb:
		bombNeighbors +=1
		setText(("%d" % bombNeighbors))






func _input_event(viewport, event, intt):
	if printed < 0:
		#print("_input clicked ", event, " ", typeof(event))
		printed += 1
	if event is InputEventMouseButton and event.pressed:
		#print("button pressed ", event)
		triggerCell()



func triggerCell(popping=false):
	if isBomb and popping:
		return
	if isBomb and not popping:
		showBomb()
	if bombNeighbors == 0:
		$'Background'.modulate = '3b3b3b'
		if not popped:
			popped = true
			Events.popZeros.emit($'.'.grid_position)
	if popping:
		return
	$'Background'.modulate = '3b3b3b'
	return





func showBomb():
	$'Label'.text = ""
	$"Bomb".visible = true
	print("bomb triggered")



