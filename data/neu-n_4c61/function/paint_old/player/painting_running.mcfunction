
execute positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^ ^ ^1
data modify storage io_neu temp set value {}
data modify storage io_neu temp.x set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0]
data modify storage io_neu temp.y set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1]
data modify storage io_neu temp.z set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2]
data modify storage io_neu player.painting.points append from storage io_neu temp

execute store result score #x_max nu_neu_m run data get storage io_neu player.painting.max_point.x 10000
execute store result score #y_max nu_neu_m run data get storage io_neu player.painting.max_point.y 10000
execute store result score #z_max nu_neu_m run data get storage io_neu player.painting.max_point.z 10000
execute store result score #x_min nu_neu_m run data get storage io_neu player.painting.min_point.x 10000
execute store result score #y_min nu_neu_m run data get storage io_neu player.painting.min_point.y 10000
execute store result score #z_min nu_neu_m run data get storage io_neu player.painting.min_point.z 10000
execute store result score #x nu_neu_m run data get storage io_neu temp.x 10000
execute store result score #y nu_neu_m run data get storage io_neu temp.y 10000
execute store result score #z nu_neu_m run data get storage io_neu temp.z 10000
execute store result storage io_neu player.painting.max_point.x double 0.0001 run scoreboard players operation #x_max nu_neu_m > #x nu_neu_m
execute store result storage io_neu player.painting.max_point.y double 0.0001 run scoreboard players operation #y_max nu_neu_m > #y nu_neu_m
execute store result storage io_neu player.painting.max_point.z double 0.0001 run scoreboard players operation #z_max nu_neu_m > #z nu_neu_m
execute store result storage io_neu player.painting.min_point.x double 0.0001 run scoreboard players operation #x_min nu_neu_m < #x nu_neu_m
execute store result storage io_neu player.painting.min_point.y double 0.0001 run scoreboard players operation #y_min nu_neu_m < #y nu_neu_m
execute store result storage io_neu player.painting.min_point.z double 0.0001 run scoreboard players operation #z_min nu_neu_m < #z nu_neu_m

execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] double 0.00005 run scoreboard players operation #x_max nu_neu_m += #x_min nu_neu_m
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1] double 0.00005 run scoreboard players operation #y_max nu_neu_m += #y_min nu_neu_m
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] double 0.00005 run scoreboard players operation #z_max nu_neu_m += #z_min nu_neu_m
execute at 9e6925b-2-6224-0-f0d3ffc170ff facing 0. 0. 0. positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^ ^ ^1

execute store result score #xn nu_neu_m run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] 1000
execute store result score #yn nu_neu_m run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1] 1000
execute store result score #zn nu_neu_m run data get entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] 1000

data modify storage kaer_test1 temp1 set from storage io_neu player.painting.points
execute store result score loop nu_neu_m run data get storage kaer_test1 temp1
function neu-n_4c61:paint_old/player/painting_end/loop
