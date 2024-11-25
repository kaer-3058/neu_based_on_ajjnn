data modify storage kaer_test1 temp2 set value {x:0,y:0}
execute store result score #temp1 int run data get storage kaer_test1 temp_grid_xy[0].x
execute store result storage kaer_test1 temp2.x int 1 run scoreboard players operation #temp1 int += #dx int
execute store result score #temp1 int run data get storage kaer_test1 temp_grid_xy[0].y
execute store result storage kaer_test1 temp2.y int 1 run scoreboard players operation #temp1 int += #dy int

data modify storage kaer_test1 temp1 append from storage kaer_test1 temp2
data remove storage kaer_test1 temp_grid_xy[0]
execute if data storage kaer_test1 temp_grid_xy[0] run function neu-n_4c61:paint/player/painting_end/math/loop2
