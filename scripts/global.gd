extends Node

var atualColor

var activePoints = []

var imino = [Vector2(4, 1), Vector2(5, 1), Vector2(6, 1), Vector2(7, 1)]

var tmino = [Vector2(5, 2), Vector2(5, 1), Vector2(4, 2), Vector2(6, 2)]

var omino = [Vector2(5, 1), Vector2(6, 1), Vector2(5, 2), Vector2(6, 2)]

var smino = [Vector2(5, 2), Vector2(5, 1), Vector2(6, 1), Vector2(4, 2)]

var lmino = [Vector2(5, 2), Vector2(6, 1), Vector2(4, 2), Vector2(6, 2)]

var jmino = [Vector2(5, 2), Vector2(4, 1), Vector2(4, 2), Vector2(6, 2)]

var zmino = [Vector2(5, 2), Vector2(6, 2), Vector2(4, 1), Vector2(5, 1)]

var centers = [Vector2(192, 32), Vector2(176, 80), Vector2(192, 64), Vector2(176, 80), Vector2(176, 80), Vector2(176, 80), Vector2(176, 80)]

var pieces = [imino, omino, tmino, smino, lmino, jmino, zmino]
