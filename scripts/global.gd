extends Node

var activePoints = []

var imino = [Vector2(4, 1), Vector2(5, 1), Vector2(6, 1), Vector2(7, 1)]

var tmino = [Vector2(5, 1), Vector2(4, 2), Vector2(5, 2), Vector2(6, 2)]

var omino = [Vector2(5, 1), Vector2(6, 1), Vector2(5, 2), Vector2(6, 2)]

var smino = [Vector2(5, 1), Vector2(6, 1), Vector2(4, 2), Vector2(5, 2)]

var lmino = [Vector2(6, 1), Vector2(4, 2), Vector2(5, 2), Vector2(6, 2)]

var jmino = [Vector2(4, 1), Vector2(4, 2), Vector2(5, 2), Vector2(6, 2)]

var pieces = [imino, tmino, omino, smino, lmino, jmino]
