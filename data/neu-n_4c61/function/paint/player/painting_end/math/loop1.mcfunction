data modify storage kaer_test1 temp2 set value {x:0,y:0}

execute store result storage kaer_test1 temp1 double .000001 run function neu-n_4c61:paint/player/painting_end/math/macro1 with storage kaer_test1
execute store result score #temp_x int run data get storage kaer_test1 temp1 10

execute store success score #is- int if score #temp_x int matches ..-1
execute if score #is- int matches 1 store result score #temp_x int run data get storage kaer_test1 temp1 -10

scoreboard players operation #temp2 int = #temp_x int
scoreboard players operation #temp2 int %= 10 const
execute if score #temp2 int matches 9 run scoreboard players add #temp_x int 10
scoreboard players operation #temp_x int /= 10 const

execute if score #is- int matches 1 run scoreboard players operation #temp_x int *= -1 const

execute store result storage kaer_test1 temp2.x int 1 run scoreboard players get #temp_x int
data remove storage kaer_test1 temp_relative_x[0]


execute store result storage kaer_test1 temp1 double .000001 run function neu-n_4c61:paint/player/painting_end/math/macro2 with storage kaer_test1
execute store result score #temp_y int run data get storage kaer_test1 temp1 10

execute store success score #is- int if score #temp_y int matches ..-1
execute if score #is- int matches 1 store result score #temp_y int run data get storage kaer_test1 temp1 -10

scoreboard players operation #temp2 int = #temp_y int
scoreboard players operation #temp2 int %= 10 const
execute if score #temp2 int matches 9 run scoreboard players add #temp_y int 10
scoreboard players operation #temp_y int /= 10 const

execute if score #is- int matches 1 run scoreboard players operation #temp_y int *= -1 const

execute store result storage kaer_test1 temp2.y int 1 run scoreboard players add #temp_y int 1
data modify storage kaer_test1 temp_grid_xy append from storage kaer_test1 temp2
data remove storage kaer_test1 temp_relative_y[0]

#加粗笔画
scoreboard players operation #temp_x2 int = #temp_x int
scoreboard players operation #temp_y2 int = #temp_y int
scoreboard players add #temp_x2 int 1
scoreboard players add #temp_y2 int 1
execute store result storage kaer_test1 temp2.x int 1 run scoreboard players get #temp_x int
execute store result storage kaer_test1 temp2.y int 1 run scoreboard players get #temp_y2 int
data modify storage kaer_test1 temp_grid_xy append from storage kaer_test1 temp2
execute store result storage kaer_test1 temp2.x int 1 run scoreboard players get #temp_x2 int
execute store result storage kaer_test1 temp2.y int 1 run scoreboard players get #temp_y int
data modify storage kaer_test1 temp_grid_xy append from storage kaer_test1 temp2
execute store result storage kaer_test1 temp2.x int 1 run scoreboard players get #temp_x2 int
execute store result storage kaer_test1 temp2.y int 1 run scoreboard players get #temp_y2 int
data modify storage kaer_test1 temp_grid_xy append from storage kaer_test1 temp2


execute if data storage kaer_test1 temp_relative_x[0] run function neu-n_4c61:paint/player/painting_end/math/loop1
