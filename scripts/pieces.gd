extends TileMapLayer

var centro

func getCenter(pontos):
	var soma_x = 0
	var soma_y = 0
	for ponto in pontos:
		soma_x += ponto.x
		soma_y += ponto.y
	return Vector2(soma_x / pontos.size(), soma_y / pontos.size())

func rotating(ponto, center):
	var x = ponto.x - centro.x
	var y = ponto.y - centro.y
	var novo_x = -y
	var novo_y = x
	return Vector2(novo_x + center.x, novo_y + center.y)
	
func _ready():
	var color : Vector2i = Vector2i(0, 0)
	centro = getCenter(Global.tmino)
	Global.activePoints = Global.tmino
	for pos in Global.activePoints:
		set_cell(pos, 0, color)

func _input(event: InputEvent):
	if(event.is_action_pressed("Rotate")):
		for pos in Global.activePoints:
			erase_cell(pos)
		
		var newPoints = []
		for pos in Global.activePoints:
			newPoints.append(rotating(pos, centro))
		
		for pos in newPoints:
			set_cell(pos, 0, Vector2(0, 0))
		Global.activePoints = newPoints
		
func _process(delta: float):
	pass
