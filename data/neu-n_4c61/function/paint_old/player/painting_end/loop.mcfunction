execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] double 0.001 store result score #xe nu_neu_m run data get storage kaer_test1 temp1[0].x 1000
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1] double 0.001 store result score #ye nu_neu_m run data get storage kaer_test1 temp1[0].y 1000
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] double 0.001 store result score #ze nu_neu_m run data get storage kaer_test1 temp1[0].z 1000
execute at 9e6925b-2-6224-0-f0d3ffc170ff facing 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff 0. 0. 0. ~ ~

scoreboard players operation #xe nu_neu_m *= #xn nu_neu_m
scoreboard players operation #ye nu_neu_m *= #yn nu_neu_m
scoreboard players operation #ze nu_neu_m *= #zn nu_neu_m
scoreboard players operation #xe nu_neu_m += #ye nu_neu_m
scoreboard players operation #xe nu_neu_m += #ze nu_neu_m
scoreboard players operation #xe nu_neu_m /= 1000 const
scoreboard players operation #lambda nu_neu_m = canva_distance nu_neu_m
execute store result storage io_neu z double 0.001 run scoreboard players operation #lambda nu_neu_m /= #xe nu_neu_m
execute rotated as 9e6925b-2-6224-0-f0d3ffc170ff anchored eyes run function neu-n_4c61:paint_old/player/painting_end/macro_particle with storage io_neu


execute if score loop nu_neu_m matches ..1 run return 0
scoreboard players remove loop nu_neu_m 1
data remove storage kaer_test1 temp1[0]
function neu-n_4c61:paint_old/player/painting_end/loop
