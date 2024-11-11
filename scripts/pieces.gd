extends TileMapLayer

var cntSpin

var controle

var atualCenter

var select

@onready var board = get_parent().get_node("Board")

func rotatePoint(point, center):
    var x = point.x - center.x
    var y = point.y - center.y
    var newX = -y
    var newY = x
    return Vector2(newX + center.x, newY + center.y)

func canMove(postPoints):
    for point in postPoints:
        var cellPosition = board.get_cell_source_id(point)
        if(cellPosition != -1):
            return false
    return true

func plot(ponto):
    var nova = Sprite2D.new()
    nova.texture = preload("res://assets/5x5_red.png")
    nova.position = ponto
    add_child(nova)

func getCenter():
    if(select > 1):
        return map_to_local(Global.activePoints[0])
    var temp : Vector2
    for pos in Global.activePoints:
        temp += pos
    temp /= 4
    if(cntSpin % 4 == 0 || cntSpin % 4 == 3):
        return map_to_local(temp) + Vector2(16, 16)
    elif(cntSpin % 4 == 1):
        return map_to_local(temp) + Vector2(-16, 16)
    elif(cntSpin % 4 == 2):
        return map_to_local(temp) + Vector2(16, -16)

func rotatePiece():
    if(select == 1):
        return
    var tilePoints = []
    atualCenter = getCenter()
    cntSpin += 1
    for pos in Global.activePoints:
        var rotatedPos = rotatePoint(map_to_local(pos), atualCenter)
        tilePoints.append(Vector2(local_to_map(rotatedPos)))
        
    if(!canMove(tilePoints)):
        return
    dellPiece()
    Global.activePoints = tilePoints
    if(willStop(Global.activePoints)):
        drawPiece(board)
        newPiece()
    else:
        drawPiece(self)
    
func newPiece():
    cntSpin = 0
    select = randi_range(0, 6)
    Global.activePoints = Global.pieces[select]
    drawPiece(self)
        
func _ready():
    newPiece()
    get_parent().get_node("TimerH").timeout.connect(on_timeoutHorizontal)
    get_parent().get_node("TimerV").timeout.connect(on_timeoutVertical)
    #set_cell(Vector2(2, 21), 0, Vector2(1, 0))

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

func on_timeoutVertical():
    movePiece(Vector2.DOWN)
