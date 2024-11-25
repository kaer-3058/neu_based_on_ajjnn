data modify storage io player.painting.output append value {}
data modify storage kaer_test1 temp_out_int_x append value 0
data modify storage kaer_test1 temp_out_int_y append value 0

# d * (vec(e)/(vec(n).vec(e)) - vec(n))
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0] double 0.000001 store result score #xe num store result score #x num run data get storage io player.painting.points[0].x 1000000
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1] double 0.000001 store result score #ye num store result score #y num run data get storage io player.painting.points[0].y 1000000
execute store result entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2] double 0.000001 store result score #ze num store result score #z num run data get storage io player.painting.points[0].z 1000000
execute at 9e6925b-2-6224-0-f0d3ffc170ff facing 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff 0. 0. 0. ~ ~


# vec(n).vec(e)
scoreboard players operation #xe num /= 1000 const
scoreboard players operation #ye num /= 1000 const
scoreboard players operation #ze num /= 1000 const
scoreboard players operation #xe num *= #xn num
scoreboard players operation #ye num *= #yn num
scoreboard players operation #ze num *= #zn num
scoreboard players operation #xe num += #ye num
scoreboard players operation #xe num += #ze num
scoreboard players operation #xe num /= 1000 const

# vec(e)/(vec(n).vec(e)) - vec(n)
scoreboard players operation #x num /= #xe num
scoreboard players operation #y num /= #xe num
scoreboard players operation #z num /= #xe num

scoreboard players operation #x num -= #xn num
scoreboard players operation #y num -= #yn num
scoreboard players operation #z num -= #zn num

# d * (vec(e)/(vec(n).vec(e)) - vec(n))
scoreboard players operation #x num *= canva_distance num
scoreboard players operation #y num *= canva_distance num
scoreboard players operation #z num *= canva_distance num
execute store result score #x2 num run scoreboard players operation #x num /= 1000 const
execute store result score #y2 num run scoreboard players operation #y num /= 1000 const
execute store result score #z2 num run scoreboard players operation #z num /= 1000 const

# vec(a).vec(u)
scoreboard players operation #x num *= #xu num
scoreboard players operation #z num *= #zu num
execute store result storage io player.painting.output[-1].x double 0.000000001 run scoreboard players operation #x num += #z num
execute store result storage kaer_test1 temp_out_int_x[-1] int 0.001 run scoreboard players get #x num


# vec(a).vec(v)
scoreboard players operation #x2 num *= #xv num
scoreboard players operation #y2 num *= #yv num
scoreboard players operation #z2 num *= #zv num
scoreboard players operation #x2 num += #y2 num
execute store result storage io player.painting.output[-1].y double 0.000000001 run scoreboard players operation #x2 num += #z2 num
execute store result storage kaer_test1 temp_out_int_y[-1] int 0.001 run scoreboard players get #x2 num

#function neu-n_4c61:paint/player/painting_end/macro_particle with storage io player.painting.output[-1]

execute if score loop num matches ..1 run return 0
scoreboard players remove loop num 1
data remove storage io player.painting.points[0]
function neu-n_4c61:paint/player/painting_end/loop
