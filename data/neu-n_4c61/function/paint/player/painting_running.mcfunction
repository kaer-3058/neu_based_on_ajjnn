
execute positioned 0. 0. 0. run tp 9e6925b-2-6224-0-f0d3ffc170ff ^ ^ ^1
data modify storage io temp set value {}
data modify storage io temp.x set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[0]
data modify storage io temp.y set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[1]
data modify storage io temp.z set from entity 9e6925b-2-6224-0-f0d3ffc170ff Pos[2]

data modify storage io player.painting.points append from storage io temp


execute store result score #x_max num run data get storage io player.painting.max_point.x 10000
execute store result score #y_max num run data get storage io player.painting.max_point.y 10000
execute store result score #z_max num run data get storage io player.painting.max_point.z 10000
execute store result score #x_min num run data get storage io player.painting.min_point.x 10000
execute store result score #y_min num run data get storage io player.painting.min_point.y 10000
execute store result score #z_min num run data get storage io player.painting.min_point.z 10000
execute store result score #x num run data get storage io temp.x 10000
execute store result score #y num run data get storage io temp.y 10000
execute store result score #z num run data get storage io temp.z 10000
execute store result storage io player.painting.max_point.x double 0.0001 run scoreboard players operation #x_max num > #x num
execute store result storage io player.painting.max_point.y double 0.0001 run scoreboard players operation #y_max num > #y num
execute store result storage io player.painting.max_point.z double 0.0001 run scoreboard players operation #z_max num > #z num
execute store result storage io player.painting.min_point.x double 0.0001 run scoreboard players operation #x_min num < #x num
execute store result storage io player.painting.min_point.y double 0.0001 run scoreboard players operation #y_min num < #y num
execute store result storage io player.painting.min_point.z double 0.0001 run scoreboard players operation #z_min num < #z num
