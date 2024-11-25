execute store result score #temp1 int run data get storage kaer_test1 temp_out_int_y[0]
execute store result storage kaer_test1 temp1 int 1 run scoreboard players operation #temp1 int -= #temp_min_y int
data modify storage kaer_test1 temp_relative_y append from storage kaer_test1 temp1

data remove storage kaer_test1 temp_out_int_y[0]
execute if data storage kaer_test1 temp_out_int_y[0] run function neu-n_4c61:paint/player/painting_end/math/loop4
