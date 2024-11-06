extends TileMapLayer

var select

@onready var board = get_parent().get_node("Board")

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
    return Vector2((newX + center.x), (newY + center.y))

func canMove(postPoints):
    for point in postPoints:
        var cellPosition = board.get_cell_source_id(point)
        if(cellPosition != -1):
            return false
    return true

func rotatePiece():
    var newPoints = []
    var atualCenter = getCenter(Global.activePoints)
    for pos in Global.activePoints:
        newPoints.append(rotatePoint(pos, atualCenter))
    if(!canMove(newPoints)):
        return
    dellPiece()
    Global.activePoints = newPoints
    if(willStop(Global.activePoints)):
        drawPiece(board)
        newPiece()
    else:
        drawPiece(self)
    
func newPiece():
    select = randi_range(0, 5)
    print(select)
    Global.activePoints = Global.pieces[select]
    drawPiece(self)
        
func _ready():
    newPiece()
    get_parent().get_node("TimerH").timeout.connect(on_timeoutHorizontal)
    get_parent().get_node("TimerV").timeout.connect(on_timeoutVertical)
    set_cell(Vector2(2, 21), 0, Vector2(1, 0))

func dellPiece():
    for pos in Global.activePoints:
        erase_cell(pos)	

func drawPiece(tilePlace):
    for pos in Global.activePoints:
        tilePlace.set_cell(pos, 0, Vector2(select, 0))

func willStop(postPoints):
    for point in postPoints:
        var cellid = board.get_cell_source_id(point + Vector2.DOWN)
        if cellid != -1:
            return true
    return false

func movePiece(direction : Vector2):
    var newPos = []
    for pos in Global.activePoints:
        newPos.append(pos + direction)
    if(!canMove(newPos)):
        return
    dellPiece()
    Global.activePoints = newPos
    if(willStop(Global.activePoints)):
        drawPiece(board)
        newPiece()
    else:
        drawPiece(self)

func on_timeoutHorizontal():
    if Input.is_action_just_pressed("ui_up"):
        rotatePiece()
    if Input.is_action_pressed("ui_down"):
        movePiece(Vector2.DOWN * 0.3)
        
    var directions = {
        "ui_left" : Vector2.LEFT,
        "ui_right" : Vector2.RIGHT
    }
    
    for key in directions.keys():
        if Input.is_action_just_pressed(key):
            movePiece(directions[key])
            break

func on_timeoutVertical() -> void:
    movePiece(Vector2.DOWN)
