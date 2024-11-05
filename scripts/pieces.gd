extends TileMapLayer

var speed

var steps = [0, 0, 0]

var stepsLeft

var stepsReq

var select

func getCenter(pontos):
    var soma_x = 0
    var soma_y = 0
    for ponto in pontos:
        soma_x += ponto.x
        soma_y += ponto.y
    return Vector2(soma_x / pontos.size(), soma_y / pontos.size())

func rotatePoint(point, center):
    var x = point.x - center.x
    var y = point.y - center.y
    var newX = -y
    var newY = x
    return Vector2(newX + center.x, newY + center.y)
    
func rotatePiece():
    dellPiece()
    var newPoints = []
    var atualCenter = getCenter(Global.activePoints)
    for pos in Global.activePoints:
        newPoints.append(rotatePoint(pos, atualCenter))		
    Global.activePoints = newPoints
    drawPiece()
    
func newPiece():
    select = randi_range(0, 5)
    Global.activePoints = Global.pieces[select]
    drawPiece()
        
func _ready():
    speed = 1.0
    steps = [0, 0, 0]
    stepsReq = 50
    newPiece()

func dellPiece():
    for pos in Global.activePoints:
        erase_cell(pos)	

func drawPiece():
    for pos in Global.activePoints:
        set_cell(pos, 0, Vector2(select, 0))
    
func getMove():
    if Input.is_action_just_pressed("ui_up"):
        rotatePiece()	
    if Input.is_action_pressed("ui_down"):
        steps[2] += 10
    if Input.is_action_pressed("ui_left"):
        steps[0] += 10
    if Input.is_action_pressed("ui_right"):
        steps[1] += 10
        
func _process(delta: float):
    getMove()
    steps[2] += speed
    var directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN]
    for i in range(3):
        if steps[i] > stepsReq:
            movePiece(directions[i])
            steps[i] = 0

func movePiece(direction : Vector2):
    dellPiece()
    var newPos = []
    for pos in Global.activePoints:
        newPos.append(pos + direction)
    Global.activePoints = newPos
    drawPiece()
